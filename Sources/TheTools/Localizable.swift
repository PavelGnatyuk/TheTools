//
//  Localizable.swift
//  
//
//  [Understanding Property Wrappers in Swift By Examples](https://medium.com/swlh/understanding-property-wrappers-in-swift-by-examples-604206022b5c)
//
//  Created by Pavel Gnatyuk on 15/11/2019.
//

import Foundation

@propertyWrapper
public struct Localizable {
    
    private var key: String
    
    public var wrappedValue: String {
        get { NSLocalizedString(key, comment: "") }
        set { key = newValue }
    }
    
    public init(wrappedValue: String) {
        self.key = wrappedValue
    }
}
