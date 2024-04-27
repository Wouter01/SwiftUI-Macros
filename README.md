# SwiftUI-Macros

A library of useful macros for SwiftUI.

Swift 5.9 or later is required to use this package.

## Installation
#### Swift Package Manager

Add the dependency:
```swift
dependencies: [
    .package(url: "https://github.com/Wouter01/SwiftUI-Macros.git", from: "1.0.0")
]
 ```
 
 Add the dependency to your target:
 ```swift
.target(
    name: "MyTarget",
    dependencies: [.product(name: "SwiftUIMacros", package: "SwiftUI-Macros")]
)
 ```


## Environment

To allow easier creation of new environment keys, two macros are available:
#### EnvironmentKey
Apply this macro to a variable inside an `EnvironmentValues` extension to add it to the environment.
The assigned value is the default value and is required, unless the type is Optional.
The type can be inferred by its value, just like in normal Swift code.
```swift
import SwiftUIMacros

extension EnvironmentValues {
    @EnvironmentKey
    var alignment: Alignment = .center
}

// Expands to
extension EnvironmentValues {
    var alignment: Alignment {
      get {
        self[EnvironmentKey_alignment.self]
      }
      set {
        self[EnvironmentKey_alignment.self] = newValue
      }
    }
    
    private struct EnvironmentKey_alignment: EnvironmentKey {
       static let defaultValue: Alignment = .center
    }
}
```

#### EnvironmentValues
Apply this to an `EnvironmentValues` extension to add the `EnviromentKey` macro to each variable inside the extension.

```swift
import SwiftUIMacros

@EnvironmentValues
extension EnvironmentValues {
    var alignment: Alignment = .center
    
    var secondaryFont: Font?
    
    var gridLines = 0
}

// Expands to
extension EnvironmentValues {
    @EnvironmentKey
    var alignment: Alignment = .center
    
    @EnvironmentKey
    var secondaryFont: Font?
    
    @EnvironmentKey
    var gridLines = 0
}
```

## Focus

To allow easier creation of new focusedValue keys, two macros are available:

#### FocusedValueKey
Apply this macro to a variable inside a `FocusedValues` extension to add it to the focused values.
```swift
import SwiftUIMacros

extension FocusedValues {
    @FocusedValueKey
    var enabled: Bool?
}

// Expands to
extension FocusedValues {
    @FocusedValueKey
    var enabled: Bool? {
        get {
            self [FocusedValueKey_enabled.self]
        }
        set {
            self [FocusedValueKey_enabled.self] = newValue
        }
    }
    
    private struct FocusedValueKey_enabled: FocusedValueKey {
        typealias Value = Bool
    }
}
```

#### FocusedValues
Apply this to an `FocusedValues` extension to add the `FocusedValueKey` macro to each variable inside the extension.

```swift
import SwiftUIMacros

@FocusedValues
extension FocusedValues {
    var showCompletions: Binding<Bool>?

    var value: Int?
}

// Expands to
extension FocusedValues {
    @FocusedValueKey
    var showCompletions: Binding<Bool>?

    @FocusedValueKey
    var value: Int?
}
```
