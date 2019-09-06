//
//  KeyValueObservable.swift
//
//  Created by Pavel Gnatyuk on 06/09/2019.
//
//
//  The source code was taken from an blog post [AUGMENTED CODE. Performant, sleek and elegant.](https://augmentedcode.io/2019/08/05/key-value-observing-without-nsobject-and-dynamic-in-swift/?utm_source=The.Swift.Dev.&utm_campaign=46fb3c1c34-theswiftdev-august-2019&utm_medium=email&utm_term=0_74ddbfe94a-46fb3c1c34-4192255)
//

/*
 Example:

 ```
 final class Event: KeyValueObservable {
    let observationStore = ObservationStore<Event>()
    
    var title: String = "Initial Title" {
        didSet {
            didChangeValue(for: \Event.title)
        }
    }
}

final class ViewController: UIViewController {
    let event = Event()
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        event.addObserver(self, keyPath: \.title, options: .initial) { (observer, title) in
            observer.label.text = title
        }
    }
    
    @IBAction func changeTitle(_ sender: Any) {
        event.title = "New Title"
    }
}
```
 */

import Foundation

public protocol KeyValueObservable where Self: AnyObject {
    /// Stores all the added observations.
    var observationStore: ObservationStore<Self> { get }
    
    /// Sends key-value change notification to all the observers for this key path.
    func didChangeValue(for keyPath: PartialKeyPath<Self>)
    
    /// Adds observer for key path and returns observation token.
    /// - Note: Observation token is only useful if it is needed to remove observation before observer is deallocated. When observer is deallocated, then observation is removed when next key value change is handled.
    @discardableResult func addObserver<Observer: AnyObject, Value>(_ observer: Observer,
                                                                    keyPath: KeyPath<Self, Value>,
                                                                    options: Observation.Options,
                                                                    handler: @escaping (Observer, Value) -> Void) -> Observation
    
    /// Removes added observation.
    func removeObservation(_ observation: Observation)
}

public extension KeyValueObservable {
    @discardableResult func addObserver<Observer: AnyObject, Value>(_ observer: Observer, keyPath: KeyPath<Self, Value>, options: Observation.Options, handler: @escaping (Observer, Value) -> Void) -> Observation {
        let observation = Observation()
        let observationHandler: (PartialKeyPath<Self>) -> Bool = { [weak self, weak observer] changedKeyPath in
            guard let self = self else { return false }
            guard let observer = observer else { return false }
            guard changedKeyPath == keyPath else { return true }
            handler(observer, self[keyPath: keyPath])
            return true
        }
        observationStore.observationInfos[observation] = observationHandler
        
        if options.contains(.initial) {
            handler(observer, self[keyPath: keyPath])
        }
        
        return observation
    }
    
    func removeObservation(_ observation: Observation) {
        observationStore.observationInfos.removeValue(forKey: observation)
    }
    
    func didChangeValue(for keyPath: PartialKeyPath<Self>) {
        observationStore.observationInfos = observationStore.observationInfos.filter({ (_, handler) -> Bool in
            return handler(keyPath)
        })
    }
}

public final class ObservationStore<T> {
    fileprivate var observationInfos = [Observation: (PartialKeyPath<T>) -> Bool]()
    
    var observations: [Observation] {
        return observationInfos.map({ $0.key })
    }
    
    func removeAll() {
        observationInfos.removeAll()
    }
}

public struct Observation: Hashable {
    fileprivate let identifier = UUID()
    
    public struct Options: OptionSet {
        public let rawValue: Int
        public static let initial = Options(rawValue: 1 << 0)
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}
