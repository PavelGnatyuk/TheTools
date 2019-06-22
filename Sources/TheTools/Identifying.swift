//
//  ReusableIdentifier.swift
//  TheTools
//
//  Created by Pavel Gnatyuk on 12/03/2019.
//  Copyright © 2019 Pavel Gnatyuk. All rights reserved.
//

import Foundation

public protocol Identifying: class {
    static var reuseIdentifier: String { get }
}

public extension Identifying {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
