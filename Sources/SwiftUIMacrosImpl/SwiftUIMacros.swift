//
//  SwiftUIMacros.swift
//  
//
//  Created by Wouter Hennen on 14/06/2023.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SwiftUIMacros: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        EnvironmentStorage.self,
        AttachedMacroEnvironmentKey.self
    ]
}
