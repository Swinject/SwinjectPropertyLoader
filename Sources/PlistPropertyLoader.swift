//
//  PlistPropertyLoader.swift
//  Swinject
//
//  Created by mike.owens on 12/6/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation


/// The PlistPropertyLoader will load properties from plist resources
final public class PlistPropertyLoader {
    
    /// the bundle where the resource exists (defualts to mainBundle)
    fileprivate let bundle: Bundle
    
    /// the name of the JSON resource. For example, if your resource is "properties.json" then this value will be set to "properties"
    fileprivate let name: String
    
    ///
    /// Will create a plist property loader
    ///
    /// - parameter bundle: the bundle where the resource exists (defaults to mainBundle)
    /// - parameter name:   the name of the JSON resource. For example, if your resource is "properties.plist"
    ///                     then this value will be set to "properties"
    ///
    public init(bundle: Bundle? = Bundle.main, name: String) {
        self.bundle = bundle!
        self.name = name
    }
}

// MARK: - PropertyLoadable
extension PlistPropertyLoader: PropertyLoader {
    public func load() throws -> [String: Any] {
        let data = try loadDataFromBundle(bundle, withName: name, ofType: "plist")
        let plist = try PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.MutabilityOptions(), format: nil)
        guard let props = plist as? [String: Any] else {
            throw PropertyLoaderError.invalidPlistFormat(bundle: bundle, name: name)
        }
        return props
    }
}
