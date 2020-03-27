//
//  String+isBlank.swift
//  
//  Reference:
//  1. [Empty Strings in Swift](https://useyourloaf.com/blog/empty-strings-in-swift/)
//
//
//  ## Example:
//
//  "Hello".isBlank        // false
//  "   Hello   ".isBlank  // false
//  "".isBlank             // true
//  " ".isBlank            // true
//  "\t\r\n".isBlank       // true
//  "\u{00a0}".isBlank     // true
//  "\u{2002}".isBlank     // true
//  "\u{2003}".isBlank     // true
//
//
//
//  Created by Pavel Gnatyuk on 27/03/2020.
//

import Foundation

public extension String {
  var isBlank: Bool {
    return allSatisfy({ $0.isWhitespace })
  }
}

public extension Optional where Wrapped == String {
  var isBlank: Bool {
    return self?.isBlank ?? true
  }
}
