//
//  CoreDataContainer.swift
//
//  ## References:
//  1. [Core Data and App Extensions: Sharing a Single Database](https://medium.com/better-programming/core-data-and-app-extensions-sharing-a-single-database-24f8cac35faa)
//  2. [Core Data Debugging in Xcode using launch arguments](https://www.avanderlee.com/debugging/core-data-debugging-xcode/)
//
//
//  Created by Pavel Gnatyuk on 29/06/2019.
//  Copyright © 2019 Pavel Gnatyuk. All rights reserved.
//

#if os(iOS)

import Foundation
import CoreData

open class CoreDataContainer {
    public let dataFolder: URL?
    public let bundle: Bundle
    public let modelName: String
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        return NSManagedObjectModel.mergedModel(from: [self.bundle])!
    }()

    lazy var persistentContainer: NSPersistentContainer = makePersistentContainer()
    
    public lazy var viewContext: NSManagedObjectContext = {
        let context = self.persistentContainer.viewContext
        // From "Cracking the Tests for Core Data":
        // https://medium.com/flawless-app-stories/cracking-the-tests-for-core-data-15ef893a3fee
        // and from "Easier Core Data Setup with Persistent Containers":
        // https://useyourloaf.com/blog/easier-core-data-setup-with-persistent-containers/
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    /// Initialize the Core Data stack
    /// - Parameters:
    ///   - bundle: Bunlde where the data model is located
    ///   - dataFolder: folder where the data itself is located
    public init(modelName: String, bundle: Bundle, dataFolder: URL? = nil) {
        self.modelName = modelName
        self.bundle = bundle
        self.dataFolder = dataFolder
    }
    
    open func saveContext() {
        let context = self.viewContext
        if context.hasChanges {
            do {
                try context.save()
                
            } catch let error as NSError {
                // Added from a Florian book Core Data. It simply abandons the unsaved data.
                context.rollback()
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    open func updateIfNeeded(descriptions: [NSPersistentStoreDescription]) -> [NSPersistentStoreDescription] {
        guard let storeURL = dataFolder, let url = descriptions.first?.url else {
            return descriptions
        }
        let path = storeURL.appendingPathComponent(url.lastPathComponent)
        return [NSPersistentStoreDescription(url: path)]
    }
}


extension CoreDataContainer {
    func makePersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel)
        // `persistentStoreDescriptions` of the container by default is an array of one element - a path to the 'Library/Application Support/lazyness.sqlite'
        container.persistentStoreDescriptions = updateIfNeeded(descriptions: container.persistentStoreDescriptions)
        container.loadPersistentStores { (storeDescription, error) in
            debugPrint("Persistent Store: \(String(describing: storeDescription.url)) loaded:\(error == nil)")
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
        return container
    }
}

extension CoreDataContainer: CustomStringConvertible {
    public var description: String {
        let text = "\(CoreDataContainer.self) model name = \(modelName) data folder = \(String(describing: dataFolder))"
        return text
    }
}

#endif
