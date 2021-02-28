import Foundation

public protocol UserDefaultsProvider {
    var userDefaults: UserDefaults { get }
}

@propertyWrapper
public struct UserDefaultsProperty<T: Codable> {
    let key: String
    
    public init(key: String) {
        self.key = key
    }
    
    public static subscript<E: UserDefaultsProvider>(
        _enclosingInstance instance: E,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<E, T?>,
        storage storageKeyPath: ReferenceWritableKeyPath<E, Self>
    ) -> T? {
        get {
            let wrapper = instance[keyPath: storageKeyPath]
            if let value = instance.userDefaults.value(forKey: wrapper.key) {
                do {
                    let data = try UserDefaultsDecoder.decode(T.self, from: value)
                    return data
                } catch {
                    print("error \(error)")
                }
            }
            return nil
        }
        set {
            let wrapper = instance[keyPath: storageKeyPath]
            guard let newValue = newValue else {
                instance.userDefaults.removeObject(forKey: wrapper.key)
                return
            }
            do {
                let value = try UserDefaultsEncoder.encode(newValue)
                instance.userDefaults.set(value, forKey: wrapper.key)
            } catch {
                print("error \(error)")
            }
        }
    }
    
    @available(*, unavailable, message: "This property wrapper can only be applied to classes")
    public var wrappedValue: T? {
        get {
            fatalError()
        }
        set {
            fatalError()
        }
    }
}
