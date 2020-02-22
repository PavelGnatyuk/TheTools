//
//  DataControllerTests.swift
//  TheToolsTests
//
//  Created by Pavel Gnatyuk on 21/12/2019.
//

import XCTest
@testable import TheTools

#if os(iOS)

class DataControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatDataCOntrollerCanBeCreated() {
        let bundle = Bundle(for: type(of: self))
        let controller = DataController(modelName: "", bundle: bundle)
        XCTAssertNotNil(controller, "Failed to create a dummy Data Controller")
        XCTAssertEqual(controller.modelName, "", "Model name in the created Data controller instance should be empty string")
    }

    func testThatDataCOntrollerCanBeCreatedWithModelName() {
        let modelName = "model"
        let bundle = Bundle(for: type(of: self))
        let controller = DataController(modelName: modelName, bundle: bundle)
        XCTAssertNotNil(controller, "Failed to create a dummy Data Controller")
        XCTAssertEqual(controller.modelName, modelName, "Model name in the created Data controller instance does not equal to the input parameter")
    }

}

#endif
