//
//  CustomDebugStringConvertible.swift
//  
//
//  Created by Pavel Gnatyuk on 04/09/2019.
//

import Foundation

public extension CustomDebugStringConvertible {
    var debugDescription: String {
        let className = type(of: self)
        let address = "\(Unmanaged.passUnretained(self as AnyObject).toOpaque())"
        let description = "<\(className): \(address)>"
        return description
    }
}
