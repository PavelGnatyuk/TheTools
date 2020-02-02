//
//  AtomicWriteTests.swift
//  TheToolsTests
//
//  Created by Pavel Gnatyuk on 02/02/2020.
//

import XCTest
@testable import TheTools

class AtomicWriteTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testCreation() {
        let origin: Int = 5
        let x = AtomicWrite<Int>(wrappedValue: origin)
        XCTAssertEqual(x.value, origin, "Assignment failed")
    }

    func testAssignment() {
        var x = AtomicWrite<Int>(wrappedValue: 1)
        let value: Int = 5
        x.value = value
        XCTAssertEqual(x.value, value, "Mutating failed")
    }

    func testIncrementing() {
        let origin: Int = 5
        var x = AtomicWrite<Int>(wrappedValue: origin)
        x.value += 1
        XCTAssertEqual(x.value, origin + 1, "Mutating failed")
    }

    func testMutating() {
        let origin: Int = 5
        var x = AtomicWrite<Int>(wrappedValue: origin)
        x.mutate { $0 = 1_000_000 }
        XCTAssertEqual(x.value, 1_000_000, "Mutating failed")
    }

    func testMultiThreaded() {
        var x = AtomicWrite<Int>(wrappedValue: 0)
        DispatchQueue.concurrentPerform(iterations: 1_000_000) { _ in
            x.mutate { $0 += 1 }
        }
        XCTAssertEqual(x.value, 1_000_000, "Mltithreaded mutating failed")
    }
    
    func testPerformanceExample() {
        
        var x = AtomicWrite<Int>(wrappedValue: 0)
        self.measure {
            DispatchQueue.concurrentPerform(iterations: 1_000_000) { _ in
                x.value += 1
            }
        }
    }

}
