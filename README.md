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
    var note: String?
    
    // Use custom key instead of property name
    @UserDefaultsProperty(key: "data_property")
    var dataProperty: Data?
    
    // Non-optional property with default value.
    // Returns the default value if the key is not present on UserDefaults.
    // To remove custom value: MyUserDefaults.shared.userDefaults.removeObject(forKey: "userName")
    @UserDefaultsProperty
    var userName: String = "User"
    
    // Optional property with default value.
    // Because UserDefault cannot store nil information,
    // it is imposible to different intentionaly assigned nil value and nonassigned value.
    // For example:
    // MyUserDefaults.shared.role = nil
    // MyUserDefaults.shared.role == "Normal" //true
    @UserDefaultsProperty
    var role: String? = "Normal"
}
```

## Usage

```swift
func someFunction() {

    // Without fallback value

    print(MyUserDefaults.shared.note) // nil
    print(MyUserDefaults.shared.isSet(.\$note)) // false

    MyUserDefaults.shared.note = "some note"

    print(MyUserDefaults.shared.userName) // Optional("some note")
    print(MyUserDefaults.shared.isSet(.\$note)) // true

    MyUserDefaults.shared.note = nil

    print(MyUserDefaults.shared.note) // nil
    print(MyUserDefaults.shared.isSet(.\$note)) // false


    // Non optional with fallback

    print(MyUserDefaults.shared.userName) // "User"
    print(MyUserDefaults.shared.isSet(.\$userName)) // false

    MyUserDefaults.shared.userName = "User 2"

    print(MyUserDefaults.shared.userName) // "User 2"
    print(MyUserDefaults.shared.isSet(.\$userName)) // true

    MyUserDefaults.shared.remove(.\$userName)// Cannot set to nil use helper funtion

    print(MyUserDefaults.shared.userName) // "User"
    print(MyUserDefaults.shared.isSet(.\$userName)) // false

    // Optional with fallback (Not suggested, it does not feels OK)

    print(MyUserDefaults.shared.role) // "Normal"
    print(MyUserDefaults.shared.isSet(.\$role)) // false

    MyUserDefaults.shared.role = "Admin"

    print(MyUserDefaults.shared.role) // "Admin"
    print(MyUserDefaults.shared.isSet(.\$role)) // true

    MyUserDefaults.shared.role = nil // Setting nil removes the value, it will return default value

    print(MyUserDefaults.shared.role) // "Normal" // It is not nil. Returns defaults value
    print(MyUserDefaults.shared.isSet(.\$role)) // false

}

var observer: AnyCancellable? // Keep strong reference

func registerObserver() {
    observer = MyUserDefaults.shared.observer(\.$userName) { newUserName in
        print(newUserName)
    }
}

struct SomeView: View {
    @UserDefaultsStorage(AppDefaults.shared, \.$userName) private var userName

    var body: some View {
        Text(userName)
        TextEditor(text: $userName)
    }
}

```
