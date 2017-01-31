//
//  Resolver+Properties.swift
//  Swinject
//
//  Created by Yoichi Tagaya on 5/4/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import Swinject

private struct AssociatedKeys {
    fileprivate static var properties: UInt8 = 0
}

extension Resolver {
    fileprivate var properties: [String: Any] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.properties) as? [String: Any] ?? [:]
        }
    }
    
    fileprivate func setProperties(_ newProperties: [String: Any]) {
        objc_setAssociatedObject(self, &AssociatedKeys.properties, newProperties, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }

    ///
    /// Will apply the property loaded to the container. The loader will be invoked and the properties will be merged
    /// with the existing properties owned by this container. The order in which loaders are applied matters as you can
    /// apply multi property loaders to a single container so properties loaded from each loader will be merged. Therefore
    /// if loader A contains property "test.key" and loader B contains property "test.key" then if A is loaded, then B
    /// is loaded the value for "test.key" will come from loader B.
    ///
    /// - parameter loader: the loader to load properties into the container
    ///
    public func applyPropertyLoader(_ loader: PropertyLoader) throws {
        let loadedProperties = try loader.load()
        var properties = self.properties
        for (key, value) in loadedProperties {
            properties[key] = value
        }
        setProperties(properties)
    }

    /// Retrieves a property for the given name where the receiving property is optional. This is a limitation of
    /// how you can reflect a Optional<Foo> class type where you cannot determine the inner type is Foo without parsing
    /// the string description. So in order to inject into an optioanl property, you need to specify the type
    /// so we can properly cast the object
    ///
    /// - Parameter name: The name for the property
    ///
    /// - Returns: The value for the property name
    public func property<Property>(_ name: String) -> Property? {
        return properties[name] as? Property
    }
}
