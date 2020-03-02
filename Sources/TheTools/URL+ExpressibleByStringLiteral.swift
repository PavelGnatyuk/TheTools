///
///  URL+ExpressibleByStringLiteral.swift
///
/// Instead of URL(string: "url")! for statical urls.
///
/// ## References:
/// 1. [How to make custom types from strings using ExpressibleByStringLiteral](https://www.hackingwithswift.com/example-code/language/how-to-make-custom-types-from-strings-using-expressiblebystringliteral)
///
///  Created by Pavel Gnatyuk on 02/03/2020.
///

/*
 Example:
 ```
 let url: URL = "https://www.swiftbysundell.com"
 let task = URLSession.shared.dataTask(with: "https://www.swiftbysundell.com")
 ```
 */

import Foundation

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: StaticString) {
        guard let url = URL(string: "\(value)") else {
            fatalError("Invalid URL string literal: \(value)")
        }
        self = url
    }
}
