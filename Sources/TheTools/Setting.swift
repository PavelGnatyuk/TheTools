///
///  Setting.swift
///
/// The UserDefaults wrapper
///
/// ```
/// struct AppSettings {
///    @Setting(key: "username_key", defaultValue: "")
///    static var username: String
/// }
/// ```
///
/// ## Reference:
/// 1.[Property wrappers in Swift](https://swiftbysundell.com/articles/property-wrappers-in-swift/)
///
///  Created by Pavel Gnatyuk on 02/02/2020.
///

import Foundation

@propertyWrapper
public struct Setting<T> {
    private let key: String
    private let defaultValue: T
    private let storage: UserDefaults
    
    public init(key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
    
    public var wrappedValue: T {
        get {
            let value = storage.value(forKey: key) as? T
            return value ?? defaultValue
        }
        set {
            storage.setValue(newValue, forKey: key)
        }
    }
}

public extension Setting where T: ExpressibleByNilLiteral {
    init(key: String, storage: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, storage: storage)
    }
}
