//
//  Assembler+Properties.swift
//  SwinjectPropertyLoader
//
//  Created by Yoichi Tagaya on 5/8/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import Swinject

extension Assembler {
    /// Will create a new `Assembler` with the given `AssemblyType` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter propertyLoaders:    a list of property loaders to apply to the container
    /// - parameter container:          the baseline container
    ///
    public convenience init(assemblies: [Assembly], propertyLoaders: [PropertyLoader], container: Container? = Container()) throws {
        try self.init(assemblies: assemblies, container: container)
        for propertyLoader in propertyLoaders {
            try container!.applyPropertyLoader(propertyLoader)
        }
    }

    /// Will create a new `Assembler` with the given `AssemblyType` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter parentAssembler:    the baseline assembler
    /// - parameter propertyLoaders:    a list of property loaders to apply to the container
    ///
    public convenience init(assemblies: [Assembly], parentAssembler: Assembler?, propertyLoaders: [PropertyLoader]) throws {
        try self.init(assemblies: assemblies, parentAssembler: parentAssembler)
        for propertyLoader in propertyLoaders {
            try self.resolver.applyPropertyLoader(propertyLoader)
        }
    }

    /// Will apply a property loader to the container. This is useful if you want to lazy load your assemblies or build
    /// your assembler manually
    ///
    /// - parameter propertyLoader: the property loader to apply to the assembler's container
    ///
    /// - throws: PropertyLoaderError
    ///
    public func applyPropertyLoader(_ propertyLoader: PropertyLoader) throws {
        try self.resolver.applyPropertyLoader(propertyLoader)
    }
}
