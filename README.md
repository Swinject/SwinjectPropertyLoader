SwinjectPropertyLoader
========

[![Build Status](https://travis-ci.org/Swinject/SwinjectPropertyLoader.svg?branch=master)](https://travis-ci.org/Swinject/SwinjectPropertyLoader)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Version](https://img.shields.io/cocoapods/v/SwinjectPropertyLoader.svg?style=flat)](http://cocoapods.org/pods/SwinjectPropertyLoader)
[![License](https://img.shields.io/cocoapods/l/SwinjectPropertyLoader.svg?style=flat)](http://cocoapods.org/pods/SwinjectPropertyLoader)
[![Platform](https://img.shields.io/cocoapods/p/SwinjectPropertyLoader.svg?style=flat)](http://cocoapods.org/pods/SwinjectPropertyLoader)
[![Swift Version](https://img.shields.io/badge/Swift-2.2--3.0.x-F16D39.svg?style=flat)](https://developer.apple.com/swift)


SwinjectPropertyLoader is an extension of Swinject to load property values from resources that are bundled with your application or framework.

## Requirements

- iOS 8.0+ / Mac OS X 10.10+ / watchOS 2.0+ / tvOS 9.0+
- Swift 2.2 or 2.3
  - Xcode 7.0+
- Swift 3.0.x
  - Xcode 8.0+
- Carthage 0.18+ (if you use)
- CocoaPods 1.1.1+ (if you use)

## Installation

Swinject is available through [Carthage](https://github.com/Carthage/Carthage) or [CocoaPods](https://cocoapods.org).

### Carthage

To install Swinject with Carthage, add the following line to your `Cartfile`.

```
github "Swinject/Swinject" "~> 2.0.0"
github "Swinject/SwinjectPropertyLoader" "~> 1.0.0"
```

Then run `carthage update --no-use-binaries` command or just `carthage update`. For details of the installation and usage of Carthage, visit [its project page](https://github.com/Carthage/Carthage).


### CocoaPods

To install Swinject with CocoaPods, add the following lines to your `Podfile`.

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0' # or platform :osx, '10.10' if your target is OS X.
use_frameworks!

pod 'Swinject', '~> 2.0.0'
pod 'SwinjectPropertyLoader', '~> 2.0.0'
```

Then run `pod install` command. For details of the installation and usage of CocoaPods, visit [its official website](https://cocoapods.org).

## Properties

Properties are values that can be loaded from resources that are bundled with your application/framework.
Properties can then be used when assembling definitions in your container.

There are 2 types of support property formats:

 - JSON (`JsonPropertyLoader`)
 - Plist (`PlistPropertyLoader`)

Each format supports the types specified by the format itself. If JSON format is used
then your basic types: `Bool`, `Int`, `Double`, `String`, `Array` and `Dictionary` are
supported. For Plist, all types supported by the Plist are supported which include all
JSON types plus `NSDate` and `NSData`.

JSON property files also support comments which allow you to provide more context to
your properties besides your property key names. For example:

```js
{
    // Comment type 1
    "foo": "bar",

    /* Comment type 2 */
    "baz": 100,

    /**
     Comment type 3
     */
    "boo": 30.50
}
```

Loading properties into the container is as simple as:

```swift
let container = Container()

// will load "properties.json" from the main app bundle
let loader = JsonPropertyLoader(bundle: .mainBundle(), name: "properties")

try! container.applyPropertyLoader(loader)
```

Now you can inject properties into definitions registered into the container.

Consider the following definition:

```swift
class Person {
    var name: String!
    var count: Int?
    var team: String = ""
}
```

And let's say our `properties.json` file contains:

```json
{
    "name": "Mike",
    "count": 100,
    "team": "Giants"
}
```

Then we can register this Service type with properties like so:

```swift
container.register(Person.self) { r in
    let person = Person()
    person.name = r.property("name")
    person.count = r.property("count")
    person.team = r.property("team")!
}
```

This will resolve the person as:

```swift
let person = container.resolve(Person.self)!
person.name // "Mike"
person.count // 100
person.team // "Giants"
```

Properties are available on a per-container basis. Multiple property loaders can be
applied to a single container. Properties are merged in the order in which they
are applied to a container. For example, let's say you have 2 property files:

```json
{
    "message": "hello from A",
    "count": 10
}
```

And:

```json
{
    "message": "hello from B",
    "timeout": 4
}
```

If we apply property file A, then property file B to the container, the resulting
property key-value pairs would be:

```swift
message = "hello from B"
count = 10
timeout = 4
```

As you can see the `message` property was overridden. This only works for first-level
properties which means `Dictionary` and `Array` are not merged. For example:

```json
{
    "items": [
        "hello from A"
    ]
}
```
And:

```json
{
     "items": [
        "hello from B"
     ]
}
```

The resulting value for `items` would be: `[ "hello from B" ]`

## Contributors

SwinjectPropertyLoader has been originally written by [Mike Owens](https://github.com/mowens).

## License

MIT license. See the [LICENSE file](LICENSE.txt) for details.
