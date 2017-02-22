//
//  AssemblerSpec.swift.swift
//  SwinjectPropertyLoader
//
//  Created by Yoichi Tagaya on 5/8/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Swinject
import SwinjectPropertyLoader

class Assembler_PropertiesSpec: QuickSpec {
    override func spec() {
        describe("Assembler with properties") {
            it("can assembly with properties") {
                let assembler = try! Assembler(assemblies: [
                    PropertyAsssembly()
                    ], propertyLoaders: [
                        PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "first")
                    ])
                
                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "first"
            }
            
            it("can't assembly with missing properties") {
                expect {
                    try Assembler(assemblies: [
                        PropertyAsssembly()
                        ], propertyLoaders: [
                            PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "noexist")
                        ])
                    }.to(throwError(errorType: PropertyLoaderError.self))
            }
        }
        
        describe("Empty Assembler") {
            it("can create an empty assembler and build it") {
                let assembler = Assembler()
                
                let loader = PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "first")
                try! assembler.applyPropertyLoader(loader)
                
                assembler.apply(assembly: PropertyAsssembly())
                
                let cat = assembler.resolver.resolve(Animal.self)
                expect(cat).toNot(beNil())
                expect(cat!.name) == "first"
            }
        }
    }
}
