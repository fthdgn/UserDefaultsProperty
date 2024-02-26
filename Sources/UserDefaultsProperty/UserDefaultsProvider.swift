import Foundation
import Combine

public typealias Subject =  PassthroughSubject<String, Never>

public protocol UserDefaultsProvider {
    var userDefaults: UserDefaults { get }
    var changedSubject:  Subject {get}
}

public extension UserDefaultsProvider {
    func _uf_set<T: Encodable>(value: T, forKey key: String) {
        do {
            if value as AnyObject is NSNull {
                userDefaults.removeObject(forKey: key)
            } else {
                let _value = try UserDefaultsEncoder.encode(value)
                userDefaults.set(_value, forKey: key)
            }
            changedSubject.send(key)
        } catch {
            print("cannot set \(value) to key: \(key)", error)
        }
    }
    
    func _uf_get<T: Decodable>(forKey key: String) -> T? {
        guard let object = userDefaults.object(forKey: key) else {
            return nil
        }
        do {
           return try UserDefaultsDecoder.decode(T.self, from: object)
        } catch {
            print("cannot get for key: \(key)", error)
            return nil
        }
    }
    
    func _uf_get<T: Decodable>(forKey key: String, withFallback fallback: T) -> T {
        return _uf_get(forKey: key) ?? fallback
    }
}
