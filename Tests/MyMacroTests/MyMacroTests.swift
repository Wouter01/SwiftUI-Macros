import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import SwiftUIMacrosImpl

let testMacros: [String: Macro.Type] = [
    "EnvironmentStorage": EnvironmentStorage.self,
    "EnvironmentValue": AttachedMacroEnvironmentKey.self,
    "FocusedValue": AttachedMacroFocusedValueKey.self
]

final class MyMacroTests: XCTestCase {
    func testMacroWithStringLiteral() {
        assertMacroExpansion(
            """
            struct Hello {
                @EnvironmentValue
                var test: Bool = false
            }
            """,
            expandedSource:
            """
            struct Hello {
                var test: Bool {
                    get {
                        self [EnvironmentKey_test.self]
                    }
                    set {
                        self [EnvironmentKey_test.self] = newValue
                    }
                }

                private struct EnvironmentKey_test: EnvironmentKey {
                    static let defaultValue: Bool = false
                }
            }
            """,
            macros: testMacros
        )
    }

    func testFocusedValueMacro() {
        assertMacroExpansion(
            """
            struct Hello {
                @FocusedValue
                var test: Bool?
            }
            """,
            expandedSource:
            """
            struct Hello {
                var test: Bool? {
                    get {
                        self [FocusedValueKey_test.self]
                    }
                    set {
                        self [FocusedValueKey_test.self] = newValue
                    }
                }

                private struct FocusedValueKey_test: FocusedValueKey {
                    typealias Value = Bool
                }
            }
            """,
            macros: testMacros
        )
    }

    func testEnvironmentStorage() {
        assertMacroExpansion(
            """
            @EnvironmentStorage
            extension EnvironmentValues {
                var test: Bool = false
            }
            """,
            expandedSource:
            """
            extension EnvironmentValues {
                @EnvironmentKey
                var test: Bool = false
            }
            """,
            macros: testMacros
        )
    }
}
