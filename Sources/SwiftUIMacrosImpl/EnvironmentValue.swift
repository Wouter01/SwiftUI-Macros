//
//  EnvironmentValue.swift
//
//
//  Created by Wouter Hennen on 14/06/2023.
//

import SwiftSyntax
import SwiftSyntaxMacros
import SwiftDiagnostics

public struct AttachedMacroEnvironmentKey: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {

        // Skip declarations other than variables
        guard let varDecl = declaration.as(VariableDeclSyntax.self) else {
            return []
        }

        guard var binding = varDecl.bindings.first?.as(PatternBindingSyntax.self)else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.missingAnnotation))
            return []
        }

        guard let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.notAnIdentifier))
            return []
        }
        
        binding.pattern = PatternSyntax(IdentifierPatternSyntax(identifier: .identifier("defaultValue")))

        let isOptionalType = binding.typeAnnotation?.type.is(OptionalTypeSyntax.self) ?? false
        let hasDefaultValue = binding.initializer != nil
        
        guard isOptionalType || hasDefaultValue else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.noDefaultArgument))
            return []
        }

        return [
            """
            struct EnvironmentKey_\(raw: identifier): EnvironmentKey {
                static var \(binding)
            }
            """
        ]
    }
}

extension AttachedMacroEnvironmentKey: AccessorMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {

        // Skip declarations other than variables
        guard let varDecl = declaration.as(VariableDeclSyntax.self) else {
            return []
        }

        guard let binding = varDecl.bindings.first?.as(PatternBindingSyntax.self)else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.missingAnnotation))
            return []
        }

        guard let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.notAnIdentifier))
            return []
        }

        return [
            """
            get {
                self[EnvironmentKey_\(raw: identifier).self]
            }
            """,
            """
            set {
                self[EnvironmentKey_\(raw: identifier).self] = newValue
            }
            """
        ]
    }
}
