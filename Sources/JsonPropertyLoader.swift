//
//  JsonPropertyLoader.swift
//  Swinject
//
//  Created by mike.owens on 12/6/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import Foundation


/// The JsonPropertyLoader will load properties from JSON resources
final public class JsonPropertyLoader {
    
    /// the bundle where the resource exists (defaults to mainBundle)
    fileprivate let bundle: Bundle
    
    /// the name of the JSON resource. For example, if your resource is "properties.json" then this value will be set to "properties"
    fileprivate let name: String
    
    ///
    /// Will create a JSON property loader
    ///
    /// - parameter bundle: the bundle where the resource exists (defaults to mainBundle)
    /// - parameter name:   the name of the JSON resource. For example, if your resource is "properties.json"
    ///                     then this value will be set to "properties"
    ///
    public init(bundle: Bundle? = Bundle.main, name: String) {
        self.bundle = bundle!
        self.name = name
    }
    
    /// Will strip the provide string of comments. This allows JSON property files to contain comments as it
    /// is valuable to provide more context to a property then just its key-value and comments are not valid JSON
    /// so this will process the JSON string before we attempt to parse the JSON into objects
    ///
    /// Implementation influence by Typhoon:
    /// https://github.com/appsquickly/Typhoon/blob/master/Source/Configuration/ConfigPostProcessor/TyphoonConfiguration/TyphoonJsonStyleConfiguration.m#L30
    ///
    /// - Parameter str: the string to strip of comments
    ///
    /// - Returns: the json string stripper of comments
    fileprivate func stringWithoutComments(_ str: String) -> String {
        let pattern = "(([\"'])(?:\\\\\\2|.)*?\\2)|(\\/\\/[^\\n\\r]*(?:[\\n\\r]+|$)|(\\/\\*(?:(?!\\*\\/).|[\\n\\r])*\\*\\/))"
        let expression = try! NSRegularExpression(pattern: pattern, options: .anchorsMatchLines)
        let matches = expression.matches(in: str, options: [], range: NSRange(location: 0, length: str.count))
        
        let ret = NSMutableString(string: str)
        for match in matches.reversed() {
            let character = String(str[str.index(str.startIndex, offsetBy: match.range.location)])
            if character != "\'" && character != "\"" {
                ret.replaceCharacters(in: match.range, with: "")
            }
        }
        return ret as String
    }
}

// MARK: - PropertyLoadable
extension JsonPropertyLoader: PropertyLoader {
    public func load() throws -> [String: Any] {
        let contents = try loadStringFromBundle(bundle, withName: name, ofType: "json")
        let jsonWithoutComments = stringWithoutComments(contents)
        let data = jsonWithoutComments.data(using: String.Encoding.utf8)
        
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
        guard let props = json as? [String: Any] else {
            throw PropertyLoaderError.invalidJSONFormat(bundle: bundle, name: name)
        }
        return props
        
    }
}

