import Foundation

public struct UserDefaultsPropertyData<T> {
    public let key: String
    public let fallback: T
    
    public init(key: String, fallback: T) {
        self.key = key
        self.fallback = fallback
    }
}
