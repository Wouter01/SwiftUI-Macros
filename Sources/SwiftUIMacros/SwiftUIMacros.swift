//
//  SwiftUIMacros.swift
//  SwiftUIMacros
//
//  Created by Wouter Hennen on 12/06/2023.
//

/// Creates an unique EnvironmentKey for the variable and adds getters and setters.
/// The initial value of the variable becomes the default value of the EnvironmentKey.
@attached(peer, names: prefixed(EnvironmentKey_))
@attached(accessor, names: named(get), named(set))
public macro EnvironmentValue() = #externalMacro(module: "SwiftUIMacrosImpl", type: "AttachedMacroEnvironmentKey")

/// Applies the @EnvironmentValue macro to each child in the scope.
/// This should only be applied on an EnvironmentValues extension.
@attached(memberAttribute)
public macro EnvironmentStorage() = #externalMacro(module: "SwiftUIMacrosImpl", type: "EnvironmentStorage")
