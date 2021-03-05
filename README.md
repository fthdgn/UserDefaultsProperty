# UserDefaultsProperty

```swift
import Foundation
import UserDefaultsProperty

class MyUserDefaults: UserDefaultsProvider {
    let userDefaults = UserDefaults(suiteName: "custom")!
    
    @UserDefaultsProperty(key: "stringProperty")
    var stringProperty: String?
    
    @UserDefaultsProperty(key: "dataProperty")
    var dataProperty: Data?
}
```

```swift
import Foundation
import UserDefaultsProperty

class MyUserDefaults: UserDefaultsProvider, UserDefaultsCacheProvider {
    let userDefaults = UserDefaults(suiteName: "custom")!
    let cache = UserDefaultsPropertyCache()
    
    @UserDefaultsProperty(key: "stringProperty")
    var stringProperty: String?
    
    @UserDefaultsProperty(key: "dataProperty")
    var dataProperty: Data?
}
```
