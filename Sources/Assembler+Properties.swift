//
//  Assembler+Properties.swift
//  SwinjectPropertyLoader
//
//  Created by Yoichi Tagaya on 5/8/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

extension Assembler {
    /// Will create a new `Assembler` with the given `AssemblyType` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter propertyLoaders:    a list of property loaders to apply to the container
    /// - parameter container:          the baseline container
    ///
    public init(assemblies: [AssemblyType], propertyLoaders: [PropertyLoaderType], container: Container? = Container()) throws {
        self.container = container!
        if let propertyLoaders = propertyLoaders {
            for propertyLoader in propertyLoaders {
                try self.container.applyPropertyLoader(propertyLoader)
            }
        }
        runAssemblies(assemblies)
    }

    /// Will create a new `Assembler` with the given `AssemblyType` instances to build a `Container`
    ///
    /// - parameter assemblies:         the list of assemblies to build the container from
    /// - parameter parentAssembler:    the baseline assembler
    /// - parameter propertyLoaders:    a list of property loaders to apply to the container
    ///
    public init(assemblies: [AssemblyType], parentAssembler: Assembler?, propertyLoaders: [PropertyLoaderType]) throws {
        container = Container(parent: parentAssembler?.container)
        if let propertyLoaders = propertyLoaders {
            for propertyLoader in propertyLoaders {
                try self.container.applyPropertyLoader(propertyLoader)
            }
        }
        runAssemblies(assemblies)
    }

    /// Will apply a property loader to the container. This is useful if you want to lazy load your assemblies or build
    /// your assembler manually
    ///
    /// - parameter propertyLoader: the property loader to apply to the assembler's container
    ///
    /// - throws: PropertyLoaderError
    ///
    public func applyPropertyLoader(propertyLoader: PropertyLoaderType) throws {
        try self.container.applyPropertyLoader(propertyLoader)
    }
}
