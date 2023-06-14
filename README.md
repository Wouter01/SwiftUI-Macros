# SwiftUI-Macros

A library of useful macros for SwiftUI.

## Environment

To allow easier creation of new environment keys, two macros are available:
#### EnvironmentValue
Apply this macro to a variable inside an `EnvironmentValues` extension to add it to the environment.
The assigned value is the default value and is required, unless the type is Optional.
The type can be inferred by its value, just like in normal Swift code.
```swift
import SwiftUIMacros

extension EnvironmentValues {
    @EnvironmentValue
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
    
    struct EnvironmentKey_alignment: EnvironmentKey {
       static var defaultValue: Alignment = .center
    }
}
```

#### EnvironmentStorage
Apply this to an `EnvironmentValues` extension to add the `EnviromentValue` macro to each variable inside the extension.

```swift
import SwiftUIMacros

@EnvironmentStorage
extension EnvironmentValues {
    var alignment: Alignment = .center
    
    var secondaryFont: Font?
    
    var gridLines = 0
}

// Expands to
extension EnvironmentValues {
    @EnvironmentValue
    var alignment: Alignment = .center
    
    @EnvironmentValue
    var secondaryFont: Font?
    
    @EnvironmentValue
    var gridLines = 0
}
```
