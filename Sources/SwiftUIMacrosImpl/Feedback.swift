//
//  Diagnostic.swift
//
//
//  Created by Wouter Hennen on 14/06/2023.
//

import SwiftSyntax
import SwiftDiagnostics

enum Feedback: String, DiagnosticMessage {
    case noDefaultArgument
    case missingAnnotation
    case notAnIdentifier

    var severity: DiagnosticSeverity { return .error }

    var message: String {
        switch self {
        case .noDefaultArgument:
            "No default value provided."
        case .missingAnnotation:
            "No annotation provided."
        case .notAnIdentifier:
            "Identifier is not valid."
        }
    }

    var diagnosticID: MessageID {
        MessageID(domain: "SwiftUIMacros", id: rawValue)
    }
}
