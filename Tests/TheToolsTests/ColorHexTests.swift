//
//  ColorHexTests.swift
//  TheToolsTests
//
//  Created by Pavel Gnatyuk on 22/06/2019.
//

#if canImport(UIKit)

import XCTest
@testable import TheTools

class ColorHexTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatPureRedColorIsCreatedFromIntegers() {
        let color = UIColor(red: 255, green: 0, blue: 0)
        XCTAssertTrue(color.isEqual(UIColor.red))
    }

    func testThatPureGreenColorIsCreatedFromIntegers() {
        let color = UIColor(red: 0, green: 255, blue: 0)
        XCTAssertTrue(color.isEqual(UIColor.green))
    }

    func testThatPureBlueColorIsCreatedFromIntegers() {
        let color = UIColor(red: 0, green: 0, blue: 255)
        XCTAssertTrue(color.isEqual(UIColor.blue))
    }
    
    func testThatPureRedColorIsCreatedFromHex() throws {
        let color = try XCTUnwrap(UIColor(hex: "#FF0000FF"))
        XCTAssertTrue(color.isEqual(UIColor.red))
    }

}
#endif
