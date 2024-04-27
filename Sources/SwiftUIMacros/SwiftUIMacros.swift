//
//  SwiftUIMacros.swift
//  SwiftUIMacros
//
//  Created by Wouter Hennen on 12/06/2023.
//

/// Creates an unique EnvironmentKey for the variable and adds getters and setters.
/// The initial value of the variable becomes the default value of the EnvironmentKey.
@available(*, deprecated, renamed: "EnvironmentKey", message: "EnvironmentValue has been renamed to EnvironmentKey")
@attached(peer, names: prefixed(EnvironmentKey_))
@attached(accessor, names: named(get), named(set))
public macro EnvironmentValue() = #externalMacro(module: "SwiftUIMacrosImpl", type: "AttachedMacroEnvironmentKey")

/// Creates an unique EnvironmentKey for the variable and adds getters and setters.
/// The initial value of the variable becomes the default value of the EnvironmentKey.
@attached(peer, names: prefixed(EnvironmentKey_))
@attached(accessor, names: named(get), named(set))
public macro EnvironmentKey() = #externalMacro(module: "SwiftUIMacrosImpl", type: "AttachedMacroEnvironmentKey")

/// Applies the @EnvironmentValue macro to each child in the scope.
/// This should only be applied on an EnvironmentValues extension.
@available(*, deprecated, renamed: "EnvironmentValues", message: "EnvironmentStorage has been renamed to EnvironmentValues")
@attached(memberAttribute)
public macro EnvironmentStorage() = #externalMacro(module: "SwiftUIMacrosImpl", type: "EnvironmentStorage")

/// Applies the @EnvironmentValue macro to each child in the scope.
/// This should only be applied on an EnvironmentValues extension.
@attached(memberAttribute)
public macro EnvironmentValues() = #externalMacro(module: "SwiftUIMacrosImpl", type: "EnvironmentStorage")

/// Applies the @FocusedValue macro to each child in the scope.
/// This should only be applied on an FocusedValues extension.
@attached(memberAttribute)
public macro FocusedValues() = #externalMacro(module: "SwiftUIMacrosImpl", type: "EnvironmentStorage")

/// Creates an unique FocusedValueKey for the variable and adds getters and setters.
@attached(peer, names: prefixed(FocusedValueKey_))
@attached(accessor, names: named(get), named(set))
public macro FocusedValueKey() = #externalMacro(module: "SwiftUIMacrosImpl", type: "AttachedMacroFocusedValueKey")
