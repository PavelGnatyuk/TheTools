//
//  IdentifyingTests.swift
//  
//
//  Created by Pavel Gnatyuk on 06/09/2019.
//

import XCTest
@testable import TheTools

class IdentifyingTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testThatIdentifyingGivesCorrectName() {
        class Temp: Identifying {}
        let name = Temp.reuseIdentifier
        XCTAssertFalse(name.isEmpty, "Failed to identify a class")
    }
}
