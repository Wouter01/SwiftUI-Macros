import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import SwiftUIMacrosImpl

let testMacros: [String: Macro.Type] = [
    "EnvironmentValue": AttachedMacroEnvironmentKey.self,
    "EnvironmentStorage": EnvironmentStorage.self
]

final class MyMacroTests: XCTestCase {
    func testMacroWithStringLiteral() {
        assertMacroExpansion(
            """
            struct Hello {
                @EnvironmentValue(defaultValue: false)
                var test: Bool = false
            }
            """,
            expandedSource:
            """
            struct Hello {
                var test: Bool = false {
                    get {
                        self [EnvironmentKey_test.self]
                    }
                    set {
                        self [EnvironmentKey_test.self] = newValue
                    }
                }
                struct EnvironmentKey_test: EnvironmentKey {
                    static var defaultValue: Bool = false
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
            struct Hello {
                var test: Bool = false
            }
            """,
            expandedSource:
            """
            
            struct Hello {
                var test: Bool = false {
                    get {
                        self [EnvironmentKey_test.self]
                    }
                    set {
                        self [EnvironmentKey_test.self] = newValue
                    }
                }
            }
            """,
            macros: testMacros
        )
    }
}
