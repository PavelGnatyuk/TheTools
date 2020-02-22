//
//  WrapperTests.swift
//  TheToolsTests
//
//  Created by Pavel Gnatyuk on 22/02/2020.
//

import XCTest
@testable import TheTools

class WrapperTests: XCTestCase {

    func testThatCanBeCreated() {
        let controller = UIViewController()
        let wrapped = Wrapper(viewController: controller)
        XCTAssertNotNil(wrapped, "Failed to create Wrapper")
    }
    
    func testThatCreatesNavigationController() {
        let controller = UIViewController()
        let wrapped = Wrapper(viewController: controller).wrap()
        let inner = wrapped.viewControllers.first
        XCTAssertEqual(controller, inner, "Failed to wrap into navigation controller")
    }
    
}
