import Foundation
import Combine

public protocol UserDefaultsProvider {
    var userDefaults: UserDefaults { get }
}

private var changedSubjects: [UserDefaults:PassthroughSubject<String, Never>] = [:]

public extension UserDefaultsProvider {
    internal var changedSubject: PassthroughSubject<String, Never> {
        get {
            if let c = changedSubjects[userDefaults] {
                return c
            } else {
                let new = PassthroughSubject<String, Never>()
                changedSubjects[userDefaults] = new
                return new
            }
        }
    }
    
    func observe<T: Codable>(_ keyPath: KeyPath<Self, UserDefaultsPropertyData<T>>, callback: @escaping (_ value: T) -> Void) -> AnyCancellable {
        let data = self[keyPath: keyPath]
        return changedSubject.filter({$0 == data.key}).sink { _ in
            let value = _uf_get(forKey: data.key, withFallback: data.fallback)
            callback(value)
        }
    }
    
    func remove<T: Codable>(_ keyPath: KeyPath<Self, UserDefaultsPropertyData<T>>) {
        let data = self[keyPath: keyPath]
        userDefaults.removeObject(forKey: data.key)
    }
    
    func isSet<T: Codable>(_ keyPath: KeyPath<Self, UserDefaultsPropertyData<T>>) -> Bool {
        let data = self[keyPath: keyPath]
        return userDefaults.object(forKey: data.key) != nil
    }
    
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
