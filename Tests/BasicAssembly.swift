//
//  BasicAssembly.swift
//  SwinjectPropertyLoader
//
//  Created by Yoichi Tagaya on 5/8/16.
//  Copyright © 2016 Swinject Contributors. All rights reserved.
//

import Swinject

class PropertyAsssembly: AssemblyType {
    func assemble(container: Container) {
        container.register(AnimalType.self) { r in
            return Cat(name: r.property("test.string")!)
        }
    }
}
