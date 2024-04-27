//
//  FocusedValue.swift
//  
//
//  Created by Wouter on 27/4/24.
//

import SwiftSyntax
import SwiftSyntaxMacros
import SwiftDiagnostics

public struct AttachedMacroFocusedValueKey: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {

        // Skip declarations other than variables
        guard let varDecl = declaration.as(VariableDeclSyntax.self) else {
            return []
        }

        guard let binding = varDecl.bindings.first else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.missingAnnotation))
            return []
        }

        guard let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.notAnIdentifier))
            return []
        }

        guard let annotation = binding.typeAnnotation else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.typeAnnotationRequired))
            return []
        }

        guard let type = annotation.type.as(OptionalTypeSyntax.self) else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.optionalTypeRequired))
            return []
        }

        return [
            """
            private struct FocusedValueKey_\(identifier): FocusedValueKey {
                typealias Value = \(type.wrappedType)
            }
            """
        ]
    }
}

extension AttachedMacroFocusedValueKey: AccessorMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingAccessorsOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AccessorDeclSyntax] {

        // Skip declarations other than variables
        guard let varDecl = declaration.as(VariableDeclSyntax.self) else {
            return []
        }

        guard let binding = varDecl.bindings.first else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.missingAnnotation))
            return []
        }

        guard let identifier = binding.pattern.as(IdentifierPatternSyntax.self)?.identifier else {
            context.diagnose(Diagnostic(node: Syntax(node), message: Feedback.notAnIdentifier))
            return []
        }

        return [
            """
            get {
                self[FocusedValueKey_\(identifier).self]
            }
            """,
            """
            set {
                self[FocusedValueKey_\(identifier).self] = newValue
            }
            """
        ]
    }
}

