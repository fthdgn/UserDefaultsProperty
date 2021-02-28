# UserDefaultsProperty

```swift
import Foundation

class Keychain: UserDefaultsProvider {
    let userDefaults = UserDefaults(suiteName: "custom")!
    
    @UserDefaultsProperty(key: "stringProperty")
    var stringProperty: String?
    
    @UserDefaultsProperty(key: "dataProperty")
    var dataProperty: Data?
}
```
