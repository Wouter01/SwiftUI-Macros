//
//  Diagnostic.swift
//
//
//  Created by Wouter Hennen on 14/06/2023.
//

import SwiftSyntax
import SwiftDiagnostics

enum Feedback: Identifiable, DiagnosticMessage {
    case noDefaultArgument
    case missingAnnotation
    case notAnIdentifier
    case attachedToWrongType(macro: String, wrongType: String, correctType: String)
    case notAttachedToExtension
    case typeAnnotationRequired
    case optionalTypeRequired

    var severity: DiagnosticSeverity { return .error }

    var message: String {
        switch self {
        case .noDefaultArgument:
            "No default value provided."
        case .missingAnnotation:
            "No annotation provided."
        case .notAnIdentifier:
            "Identifier is not valid."
        case .attachedToWrongType(let macro, let wrongType, let correctType):
            "\(macro) is attached to \(wrongType), but must be attached to \(correctType)"
        case .notAttachedToExtension:
            "Macro can only be attached to an extension"
        case .typeAnnotationRequired:
            "Missing type declaration"
        case .optionalTypeRequired:
            "The type must be Optional."
        }
    }

    var id: String {
        switch self {
        case .noDefaultArgument:
            "noDefaultArgument"
        case .missingAnnotation:
            "missingAnnotation"
        case .notAnIdentifier:
            "notAnIdentifier"
        case .attachedToWrongType:
            "attachedToWrongType"
        case .notAttachedToExtension:
            "notAttachedToExtension"
        case .typeAnnotationRequired:
            "typeAnnotationRequired"
        case .optionalTypeRequired:
            "optionalTypeRequired"
        }
    }

    var diagnosticID: MessageID {
        MessageID(domain: "SwiftUIMacros", id: id)
    }
}
