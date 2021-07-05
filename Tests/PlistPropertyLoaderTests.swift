//
//  PlistPropertyLoaderTests.swift
//  Swinject
//
//  Created by mike.owens on 12/6/15.
//  Copyright © 2015 Swinject Contributors. All rights reserved.
//

import XCTest
import Swinject
import SwinjectPropertyLoader


class PlistPropertyLoaderTests: XCTestCase {
    func testMissingResourcesAreHandled() {
        let loader = PlistPropertyLoader(bundle: Bundle(for: type(of: self).self), name: "noexist")
        XCTAssertThrowsError(try loader.load()) { error in
            XCTAssert(error is PropertyLoaderError)
        }
    }
    
    // No test for invalid since Xcode won't allow invalid plist files to be added to the bundle
}
