//
//  Container+PropertiesSpec.swift
//  SwinjectPropertyLoader
//
//  Created by Yoichi Tagaya on 5/8/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject

class Container_PropertiesSpec: QuickSpec {
    override func spec() {
        describe("JSON properties") {
            it("can load properties from a single loader") {
                let loader = JsonPropertyLoader(bundle: NSBundle(forClass: self.dynamicType.self), name: "first")
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
                expect(properties.stringValue) == "first"
                expect(properties.optionalStringValue) == "first"
                expect(properties.implicitStringValue) == "first"
                
                expect(properties.intValue) == 100
                expect(properties.optionalIntValue) == 100
                expect(properties.implicitIntValue) == 100
                
                expect(properties.doubleValue) == 30.50
                expect(properties.optionalDoubleValue) == 30.50
                expect(properties.implicitDoubleValue) == 30.50
                
                expect(properties.arrayValue.count) == 2
                expect(properties.arrayValue[0]) == "item1"
                expect(properties.arrayValue[1]) == "item2"
                expect(properties.optionalArrayValue!.count) == 2
                expect(properties.optionalArrayValue![0]) == "item1"
                expect(properties.optionalArrayValue![1]) == "item2"
                expect(properties.implicitArrayValue.count) == 2
                expect(properties.implicitArrayValue![0]) == "item1"
                expect(properties.implicitArrayValue![1]) == "item2"
                
                expect(properties.dictValue.count) == 2
                expect(properties.dictValue["key1"]) == "item1"
                expect(properties.dictValue["key2"]) == "item2"
                expect(properties.optionalDictValue!.count) == 2
                expect(properties.optionalDictValue!["key1"]) == "item1"
                expect(properties.optionalDictValue!["key2"]) == "item2"
                expect(properties.implicitDictValue.count) == 2
                expect(properties.implicitDictValue!["key1"]) == "item1"
                expect(properties.implicitDictValue!["key2"]) == "item2"
                
                expect(properties.boolValue) == true
                expect(properties.optionalBoolValue) == true
                expect(properties.implicitBoolValue) == true
                
            }
            
            it("can load properties from multiple loader") {
                let loader = JsonPropertyLoader(bundle: NSBundle(forClass: self.dynamicType.self), name: "first")
                let loader2 = JsonPropertyLoader(bundle: NSBundle(forClass: self.dynamicType.self), name: "second")
                try! container.applyPropertyLoader(loader)
                try! container.applyPropertyLoader(loader2)
                
                container.register(Properties.self) { r in
                    let properties = Properties()
                    properties.stringValue = r.property("test.string")! // from loader2
                    properties.intValue = r.property("test.int")! // from loader
                    
                    return properties
                }
                
                let properties = container.resolve(Properties.self)!
                expect(properties.stringValue) == "second"
                expect(properties.intValue) == 100
                
            }
        }
        
        describe("Plist properties") {
            it("can load properties from a single loader") {
                let loader = PlistPropertyLoader(bundle: NSBundle(forClass: self.dynamicType.self), name: "first")
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
                expect(properties.stringValue) == "first"
                expect(properties.optionalStringValue) == "first"
                expect(properties.implicitStringValue) == "first"
                
                expect(properties.intValue) == 100
                expect(properties.optionalIntValue) == 100
                expect(properties.implicitIntValue) == 100
                
                expect(properties.doubleValue) == 30.50
                expect(properties.optionalDoubleValue) == 30.50
                expect(properties.implicitDoubleValue) == 30.50
                
                expect(properties.arrayValue.count) == 2
                expect(properties.arrayValue[0]) == "item1"
                expect(properties.arrayValue[1]) == "item2"
                expect(properties.optionalArrayValue!.count) == 2
                expect(properties.optionalArrayValue![0]) == "item1"
                expect(properties.optionalArrayValue![1]) == "item2"
                expect(properties.implicitArrayValue.count) == 2
                expect(properties.implicitArrayValue![0]) == "item1"
                expect(properties.implicitArrayValue![1]) == "item2"
                
                expect(properties.dictValue.count) == 2
                expect(properties.dictValue["key1"]) == "item1"
                expect(properties.dictValue["key2"]) == "item2"
                expect(properties.optionalDictValue!.count) == 2
                expect(properties.optionalDictValue!["key1"]) == "item1"
                expect(properties.optionalDictValue!["key2"]) == "item2"
                expect(properties.implicitDictValue.count) == 2
                expect(properties.implicitDictValue!["key1"]) == "item1"
                expect(properties.implicitDictValue!["key2"]) == "item2"
                
                expect(properties.boolValue) == true
                expect(properties.optionalBoolValue) == true
                expect(properties.implicitBoolValue) == true
                
            }
            
            it("can load properties from multiple loader") {
                let loader = PlistPropertyLoader(bundle: NSBundle(forClass: self.dynamicType.self), name: "first")
                let loader2 = PlistPropertyLoader(bundle: NSBundle(forClass: self.dynamicType.self), name: "second")
                try! container.applyPropertyLoader(loader)
                try! container.applyPropertyLoader(loader2)
                
                container.register(Properties.self) { r in
                    let properties = Properties()
                    properties.stringValue = r.property("test.string")! // from loader2
                    properties.intValue = r.property("test.int")! // from loader
                    
                    return properties
                }
                
                let properties = container.resolve(Properties.self)!
                expect(properties.stringValue) == "second"
                expect(properties.intValue) == 100
                
            }
            
        }
    }
}
