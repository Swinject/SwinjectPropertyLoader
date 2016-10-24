//
//  PropertyLoaderError.swift
//  Swinject
//
//  Created by mike.owens on 12/8/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation


/// Represents errors that can be thrown when loading properties into a container
///
/// - InvalidJSONFormat:         The JSON format of the properties file is incorrect. Must be top-level dictionary
/// - InvalidPlistFormat:        The Plist format of the properties file is incorrect. Must be top-level dictionary
/// - MissingResource:           The resource is missing from the bundle
/// - InvalidResourceDataFormat: The resource cannot be converted to NSData
///
public enum PropertyLoaderError: Error {
    case invalidJSONFormat(bundle: Bundle, name: String)
    case invalidPlistFormat(bundle: Bundle, name: String)
    case missingResource(bundle: Bundle, name: String)
    case invalidResourceDataFormat(bundle: Bundle, name: String)
}

// MARK: - CustomStringConvertible
extension PropertyLoaderError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidJSONFormat(let bundle, let name):
            return "Invalid JSON format for bundle: \(bundle), name: \(name). Must be top-level dictionary"
        case .invalidPlistFormat(let bundle, let name):
            return "Invalid Plist format for bundle: \(bundle), name: \(name). Must be top-level dictionary"
        case .missingResource(let bundle, let name):
            return "Missing resource for bundle: \(bundle), name: \(name)"
        case .invalidResourceDataFormat(let bundle, let name):
            return "Invalid resource format for bundle: \(bundle), name: \(name)"
        }
    }
}
