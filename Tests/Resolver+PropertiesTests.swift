//
//  Resolver+PropertiesTests.swift
//  SwinjectPropertyLoader
//
//  Created by Yoichi Tagaya on 5/8/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import XCTest
import Swinject
import SwinjectPropertyLoader

class Resolver_PropertiesTests: XCTestCase {
    var container: Container!

    override func setUpWithError() throws {
        container = Container()
    }
    
    // MARK: JSON properties"
    
    func testJsonPropertiesCanLoadFromSingleLoader() {
        let loader = JsonPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "first")
        try! container.applyPropertyLoader(loader)
        
        container.register(Properties.self) { r in
            let properties = Properties()
            properties.stringValue = r.property("test.string")!
            properties.optionalStringValue = r.property("test.string")
            properties.implicitStringValue = r.property("test.string")
            
            properties.intValue = r.property("test.int")!
            properties.optionalIntValue = r.property("test.int")
            properties.implicitIntValue = r.property("test.int")
            
            properties.doubleValue = r.property("test.double")!
            properties.optionalDoubleValue = r.property("test.double")
            properties.implicitDoubleValue = r.property("test.double")
            
            properties.arrayValue = r.property("test.array")!
            properties.optionalArrayValue = r.property("test.array")
            properties.implicitArrayValue = r.property("test.array")
            
            properties.dictValue = r.property("test.dict")!
            properties.optionalDictValue = r.property("test.dict")
            properties.implicitDictValue = r.property("test.dict")
            
            properties.boolValue = r.property("test.bool")!
            properties.optionalBoolValue = r.property("test.bool")
            properties.implicitBoolValue = r.property("test.bool")
            
            return properties
        }
        
        let properties = container.resolve(Properties.self)!
        XCTAssertEqual(properties.stringValue, "first")
        XCTAssertEqual(properties.optionalStringValue, "first")
        XCTAssertEqual(properties.implicitStringValue, "first")

        XCTAssertEqual(properties.intValue, 100)
        XCTAssertEqual(properties.optionalIntValue, 100)
        XCTAssertEqual(properties.implicitIntValue, 100)
        
        XCTAssertEqual(properties.doubleValue, 30.50)
        XCTAssertEqual(properties.optionalDoubleValue, 30.50)
        XCTAssertEqual(properties.implicitDoubleValue, 30.50)
        
        XCTAssertEqual(properties.arrayValue.count, 2)
        XCTAssertEqual(properties.arrayValue[0], "item1")
        XCTAssertEqual(properties.arrayValue[1], "item2")
        XCTAssertEqual(properties.optionalArrayValue!.count, 2)
        XCTAssertEqual(properties.optionalArrayValue![0], "item1")
        XCTAssertEqual(properties.optionalArrayValue![1], "item2")
        XCTAssertEqual(properties.implicitArrayValue.count, 2)
        XCTAssertEqual(properties.implicitArrayValue![0], "item1")
        XCTAssertEqual(properties.implicitArrayValue![1], "item2")
        
        XCTAssertEqual(properties.dictValue.count, 2)
        XCTAssertEqual(properties.dictValue["key1"], "item1")
        XCTAssertEqual(properties.dictValue["key2"], "item2")
        XCTAssertEqual(properties.optionalDictValue!.count, 2)
        XCTAssertEqual(properties.optionalDictValue!["key1"], "item1")
        XCTAssertEqual(properties.optionalDictValue!["key2"], "item2")
        XCTAssertEqual(properties.implicitDictValue.count, 2)
        XCTAssertEqual(properties.implicitDictValue!["key1"], "item1")
        XCTAssertEqual(properties.implicitDictValue!["key2"], "item2")
        
        XCTAssert(properties.boolValue)
        XCTAssert(properties.optionalBoolValue!)
        XCTAssert(properties.implicitBoolValue)
    }
    
    func testJsonPropertiesCanLoadFromMultipleLoaders() {
        let loader = JsonPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "first")
        let loader2 = JsonPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "second")
        try! container.applyPropertyLoader(loader)
        try! container.applyPropertyLoader(loader2)
        
        container.register(Properties.self) { r in
            let properties = Properties()
            properties.stringValue = r.property("test.string")! // from loader2
            properties.intValue = r.property("test.int")! // from loader
            
            return properties
        }
        
        let properties = container.resolve(Properties.self)!
        XCTAssertEqual(properties.stringValue, "second")
        XCTAssertEqual(properties.intValue, 100)
    }
    
    // MARK: Plist properties
    
    func testPlistPropertiesCanLoadFromSingleLoader() {
        let loader = PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "first")
        try! container.applyPropertyLoader(loader)
        
        container.register(Properties.self) { r in
            let properties = Properties()
            properties.stringValue = r.property("test.string")!
            properties.optionalStringValue = r.property("test.string")
            properties.implicitStringValue = r.property("test.string")
            
            properties.intValue = r.property("test.int")!
            properties.optionalIntValue = r.property("test.int")
            properties.implicitIntValue = r.property("test.int")
            
            properties.doubleValue = r.property("test.double")!
            properties.optionalDoubleValue = r.property("test.double")
            properties.implicitDoubleValue = r.property("test.double")
            
            properties.arrayValue = r.property("test.array")!
            properties.optionalArrayValue = r.property("test.array")
            properties.implicitArrayValue = r.property("test.array")
            
            properties.dictValue = r.property("test.dict")!
            properties.optionalDictValue = r.property("test.dict")
            properties.implicitDictValue = r.property("test.dict")
            
            properties.boolValue = r.property("test.bool")!
            properties.optionalBoolValue = r.property("test.bool")
            properties.implicitBoolValue = r.property("test.bool")
            
            return properties
        }
        
        let properties = container.resolve(Properties.self)!
        XCTAssertEqual(properties.stringValue, "first")
        XCTAssertEqual(properties.optionalStringValue, "first")
        XCTAssertEqual(properties.implicitStringValue, "first")
        
        XCTAssertEqual(properties.intValue, 100)
        XCTAssertEqual(properties.optionalIntValue, 100)
        XCTAssertEqual(properties.implicitIntValue, 100)
        
        XCTAssertEqual(properties.doubleValue, 30.50)
        XCTAssertEqual(properties.optionalDoubleValue, 30.50)
        XCTAssertEqual(properties.implicitDoubleValue, 30.50)
        
        XCTAssertEqual(properties.arrayValue.count, 2)
        XCTAssertEqual(properties.arrayValue[0], "item1")
        XCTAssertEqual(properties.arrayValue[1], "item2")
        XCTAssertEqual(properties.optionalArrayValue!.count, 2)
        XCTAssertEqual(properties.optionalArrayValue![0], "item1")
        XCTAssertEqual(properties.optionalArrayValue![1], "item2")
        XCTAssertEqual(properties.implicitArrayValue.count, 2)
        XCTAssertEqual(properties.implicitArrayValue![0], "item1")
        XCTAssertEqual(properties.implicitArrayValue![1], "item2")
        
        XCTAssertEqual(properties.dictValue.count, 2)
        XCTAssertEqual(properties.dictValue["key1"], "item1")
        XCTAssertEqual(properties.dictValue["key2"], "item2")
        XCTAssertEqual(properties.optionalDictValue!.count, 2)
        XCTAssertEqual(properties.optionalDictValue!["key1"], "item1")
        XCTAssertEqual(properties.optionalDictValue!["key2"], "item2")
        XCTAssertEqual(properties.implicitDictValue.count, 2)
        XCTAssertEqual(properties.implicitDictValue!["key1"], "item1")
        XCTAssertEqual(properties.implicitDictValue!["key2"], "item2")
        
        XCTAssert(properties.boolValue)
        XCTAssert(properties.optionalBoolValue!)
        XCTAssert(properties.implicitBoolValue)
    }
    
    func testPlistPropertiesCanLoadFromMultipleLoaders() {
        let loader = PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "first")
        let loader2 = PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "second")
        try! container.applyPropertyLoader(loader)
        try! container.applyPropertyLoader(loader2)
        
        container.register(Properties.self) { r in
            let properties = Properties()
            properties.stringValue = r.property("test.string")! // from loader2
            properties.intValue = r.property("test.int")! // from loader
            
            return properties
        }
        
        let properties = container.resolve(Properties.self)!
        XCTAssertEqual(properties.stringValue, "second")
        XCTAssertEqual(properties.intValue, 100)
    }
}
