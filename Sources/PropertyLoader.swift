//
//  PropertyLoader.swift
//  Swinject
//
//  Created by mike.owens on 12/6/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation


/// The PropertyLoader protocol defines an interface for loading properties from the applications
/// bundle that can
public protocol PropertyLoader {
    
    /// Will load the properties from the application bundle and return the properties dictionary containing
    /// the key-value pairs of the properties
    ///
    /// - returns: the key-value pair properties
    func load() throws -> [String: Any]
}

/// Helper function to load the contents of a bundle resource into a string. If the contents do not exist we will
/// we will simply return nil to allow builds to specify optional property files. This is helpful for projects
/// that white label an application that have properties that may or may not be set from a top level project.
///
/// - Parameter bundle: the bundle where the resource exists
/// - Parameter withName: the name of the resource to load (e.g. if resource is properties.json then this is properties)
/// - Parameter ofType: the type of resource to load (e.g. json)
///
/// - Returns: the contents of the resource as a string or nil if it does not exist
func loadStringFromBundle(_ bundle: Bundle, withName name: String, ofType type: String) throws -> String {
    if let resourcePath = bundle.path(forResource: name, ofType: type) {
        return try String(contentsOfFile: resourcePath)
    }
    throw PropertyLoaderError.missingResource(bundle: bundle, name: name)
}

/// Helper function to load the contes of a bundle resource into data. If the contents do not exist
/// we will simply return nil to allow builds to specify optional property files. This is helpful for projects
/// that white label an application that have properties that may or may not be set from a top level project.
///
/// - Parameter bundle: the bundle where the resource exists
/// - Parameter withName: the name of the resource to load (e.g. if resource is properties.json then this is properties)
/// - Parameter ofType: the type of resource to load (e.g. json)
///
/// - Returns: the contents of the resource as a data or nil if it does not exist
func loadDataFromBundle(_ bundle: Bundle, withName name: String, ofType type: String) throws -> Data {
    if let resourcePath = bundle.path(forResource: name, ofType: type) {
        if let data = try? Data(contentsOf: URL(fileURLWithPath: resourcePath)) {
            return data
        }
        throw PropertyLoaderError.invalidResourceDataFormat(bundle: bundle, name: name)
    }
    throw PropertyLoaderError.missingResource(bundle: bundle, name: name)
}
