import XCTest
@testable import TheTools

final class TheToolsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TheTools().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
