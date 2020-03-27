//
//  StringIsBlankTests.swift
//  TheToolsTests
//
//  Created by Pavel Gnatyuk on 27/03/2020.
//

import XCTest
@testable import TheTools

class StringIsBlankTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testThatEmptyIsBlank() throws {
        let str: String = ""
        XCTAssertTrue(str.isBlank, "Nil string is supposed to be blank")
        XCTAssertTrue("".isBlank, "Nil string is supposed to be blank")
    }
    
    func testThatHelloIsNotBlank() {
        let hello = "Hello"
        XCTAssertFalse(hello.isBlank, "Hello string is not blank")
        XCTAssertFalse("Hello".isBlank, "Hello string is not blank")
    }
    
    func testBlankCases() {
        XCTAssertTrue("".isBlank)
        XCTAssertTrue(" ".isBlank)
        XCTAssertTrue("\r".isBlank)
        XCTAssertTrue("\n".isBlank)
        XCTAssertTrue("\t".isBlank)
        XCTAssertTrue("\t\r\n".isBlank)
        XCTAssertTrue("\u{00a0}".isBlank)
        XCTAssertTrue("\u{2002}".isBlank)
        XCTAssertTrue("\u{2003}".isBlank)
    }
}
