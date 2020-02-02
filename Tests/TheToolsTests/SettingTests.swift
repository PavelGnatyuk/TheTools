//
//  SettingTests.swift
//  TheToolsTests
//
//  Created by Pavel Gnatyuk on 02/02/2020.
//

import XCTest
@testable import TheTools

class SettingTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testSettingIntDefault() {
        let value: Int = 101
        let x = Setting(key: "TestDefaultInt", defaultValue: value)
        let y = x.wrappedValue
        XCTAssertEqual(y, value, "Failed to create simple int")
    }

    func testSettingRetriveInt() {
        var x = Setting(key: "TestInt", defaultValue: 0, storage: UserDefaultsFake())
        x.wrappedValue = 135
        let stored = x.wrappedValue
        XCTAssertEqual(stored, 135, "Failed to retrieve int")
    }

    func testSettingDoubleDefault() {
        let value: Double = 100.12
        let x = Setting(key: "TestDefaultDouble", defaultValue: value)
        XCTAssertEqual(x.wrappedValue, value, "Failed to create simple double")
    }

    func testSettingRetriveDouble() {
        var x = Setting(key: "TestDouble", defaultValue: 0.0, storage: UserDefaultsFake())
        x.wrappedValue = 975.31
        let stored = x.wrappedValue
        XCTAssertEqual(stored, 975.31, "Failed to retrieve double")
    }

    func testSettingStringDefault() {
        let value: String = "Here is a value"
        let x = Setting(key: "TestDefaultString", defaultValue: value)
        XCTAssertEqual(x.wrappedValue, value, "Failed to create simple String")
    }

    func testSettingRetriveString() {
        let value: String = "Here is a string value"
        var x = Setting(key: "TestString", defaultValue: "", storage: UserDefaultsFake())
        x.wrappedValue = value
        XCTAssertEqual(x.wrappedValue, value, "Failed to create simple String")
    }

    func testSettingBoolDefault() {
        let value: Bool = true
        let x = Setting(key: "TestDefaultBool", defaultValue: value)
        XCTAssertEqual(x.wrappedValue, value, "Failed to create simple Bool")
    }

    func testSettingRetriveBool() {
        let value: Bool = true
        var x = Setting(key: "TestBool", defaultValue: false, storage: UserDefaultsFake())
        x.wrappedValue = value
        XCTAssertEqual(x.wrappedValue, value, "Failed to retrive simple Bool")
    }

    func testSettingStringArrayDefault() {
        let value: [String] = ["Hello1", "Array1"]
        let x = Setting(key: "TestdefaultStringArray", defaultValue: value)
        XCTAssertEqual(x.wrappedValue, value, "Failed to create simple Array")
    }

    func testSettingRetriveStringArray() {
        let value: [String] = ["Hello1", "Array1"]
        var x = Setting<[String]>(key: "TestDefaultStringArray", defaultValue: [])
        x.wrappedValue = value
        XCTAssertEqual(x.wrappedValue, value, "Failed to retrieve simple Array")
    }

    func testSettingStringDictionaryDefault() {
        let value: [String: String] = ["Hello2": "World3", "Array4": "Data5"]
        let x = Setting(key: "TestDefaultDictionary", defaultValue: value)
        XCTAssertEqual(x.wrappedValue, value, "Failed to create simple Dictionary")
    }

}

class UserDefaultsFake: UserDefaults {
    struct Data {
        var valueInt: Int = 0
        var valueBool: Bool = false
        var valueDouble: Double = 0.0
        var valueString: String = ""
        var valueArray: [Any] = []
        var valueDictionary: [String: Any] = [:]
    }
    
    var data = Data()
    
    override func value(forKey key: String) -> Any? {
        switch key {
        case "TestInt":
            return data.valueInt
            
        case "TestBool":
            return data.valueBool
            
        case "TestDouble":
            return data.valueDouble
            
        case "TestString":
            return data.valueString
            
        case "TestArray":
            return data.valueArray
            
        case "TestDictionary":
            return data.valueDictionary
            
        default:
            return nil
        }
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        switch key {
        case "TestInt":
            data.valueInt = value as! Int
            
        case "TestBool":
            data.valueBool = value as! Bool
            
        case "TestDouble":
            data.valueDouble = value as! Double
            
        case "TestString":
            data.valueString = value as! String
            
        case "TestArray":
            data.valueArray = value as! [AnyObject]
            
        case "TestDictionary":
            data.valueDictionary = value as! [String: AnyObject]
            
        default:
            break
        }
    }
}
