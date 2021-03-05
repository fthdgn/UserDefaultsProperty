import Foundation

public protocol UserDefaultsProvider {
    var userDefaults: UserDefaults { get }
}

public protocol UserDefaultsCacheProvider {
    var cache: UserDefaultsPropertyCache { get }
}

public class UserDefaultsPropertyCache: NSObject {
    private let cache: NSCache<NSString, AnyObject>
    
    public init(cache: NSCache<NSString, AnyObject> = .init()) {
        self.cache = cache
    }
    
    class Wrapper<T> {
        let value: T?
        
        init(_ value: T?) {
            self.value = value
        }
    }
    
    fileprivate func set<T>(value: T?, forKey key: String) {
        self.cache.setObject(Wrapper(value), forKey: key as NSString)
    }
    
    fileprivate func get<T>(forKey key: String) -> Wrapper<T>? {
        return self.cache.object(forKey: key as NSString) as? Wrapper<T>
    }
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
            
            if let wrapper: UserDefaultsPropertyCache.Wrapper<T> = (instance as? UserDefaultsCacheProvider)?.cache.get(forKey: wrapper.key) {
                return wrapper.value
            }
            
            if let value = instance.userDefaults.value(forKey: wrapper.key) {
                do {
                    let data = try UserDefaultsDecoder.decode(T.self, from: value)
                    (instance as? UserDefaultsCacheProvider)?.cache.set(value: data, forKey: wrapper.key)
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
                (instance as? UserDefaultsCacheProvider)?.cache.set(value: nil as T?, forKey: wrapper.key)
                return
            }
            do {
                let value = try UserDefaultsEncoder.encode(newValue)
                instance.userDefaults.set(value, forKey: wrapper.key)
                (instance as? UserDefaultsCacheProvider)?.cache.set(value: value, forKey: wrapper.key)
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
