# UserDefaultsProperty

## Implementation

```swift
import Foundation
import UserDefaultsProperty

// To access this without importing UserDefaultsProperty on every file
typealias UserDefaultsStorage = UserDefaultsProperty.UserDefaultsStorage

class MyUserDefaults: UserDefaultsProvider {
    static let shared: MyUserDefaults = .init()
    
    let userDefaults = UserDefaults.standard
    
    // Use property name as key on UserDefaults
    @UserDefaultsProperty
    var stringProperty: String?
    
    // Use custom key instead of property name
    @UserDefaultsProperty(key: "data_property")
    var dataProperty: Data?
    
    // Non-optional property with default value.
    // Returns the default value if the key is not present on UserDefaults.
    // To remove custom value: MyUserDefaults.shared.userDefaults.removeObject(forKey: "userName")
    @UserDefaultsProperty
    var userName: String = "someDefaultValue"
    
    // Optional property with default value.
    // Because UserDefault cannot store nil information,
    // it is imposible to different intentionaly assigned nil value and nonassigned value.
    // For example:
    // MyUserDefaults.shared.role = nil
    // MyUserDefaults.shared.role == "someDefaultValue" //true
    @UserDefaultsProperty
    var role: String? = "someDefaultValue"
}
```

## Usage

```swift
func someFunction() {
    MyUserDefaults.shared.userName = "user123"
    
    print(MyUserDefaults.shared.userName)
}

struct SomeView: View {
    @UserDefaultsStorage(AppDefaults.shared, \.$userName) private var userName: String

    var body: some View {
        Text(userName)
        TextEditor(text: $userName)
    }
}

```
