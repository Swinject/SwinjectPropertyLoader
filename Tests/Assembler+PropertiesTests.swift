//
//  AssemblerTests.swift
//  SwinjectPropertyLoader
//
//  Created by Yoichi Tagaya on 5/8/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import XCTest
import Swinject
import SwinjectPropertyLoader

class Assembler_PropertiesTests: XCTestCase {
    func testAssemblerWithPropertiesCanAssembleWithProperties() {
        let assembler = try! Assembler(assemblies: [
            PropertyAsssembly()
            ], propertyLoaders: [
                PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "first")
            ])
        
        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "first")
    }
    
    func testAssemblerWithPropertiesCanNotAssembleWithMissingProperties() {
        XCTAssertThrowsError(try Assembler(assemblies: [PropertyAsssembly()], propertyLoaders: [
                PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "noexist")
            ])) { error in
                XCTAssert(error is PropertyLoaderError)
            }
    }
    
    func testEmptyAssemblerCanCreateEmptyAsemblerAndBuildIt() {
        let assembler = Assembler()
        
        let loader = PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "first")
        try! assembler.applyPropertyLoader(loader)
        
        assembler.apply(assembly: PropertyAsssembly())
        
        let cat = assembler.resolver.resolve(Animal.self)
        XCTAssertNotNil(cat)
        XCTAssertEqual(cat!.name, "first")
    }
}
