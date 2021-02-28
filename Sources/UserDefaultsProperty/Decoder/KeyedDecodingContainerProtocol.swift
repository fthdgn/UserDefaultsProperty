import Foundation

struct _KeyedDecodingContainerProtocol<Key: CodingKey>: KeyedDecodingContainerProtocol {
    private let data: NSDictionary
    let codingPath: [CodingKey] = []
    let allKeys: [Key]
    
    init(from data: NSDictionary) {
        self.data = data
        self.allKeys = data.allKeys.map { Key(stringValue: $0 as! String)! }
    }
    
    func getData<T>(forKey key: Key) throws -> T {
        return try getData(forKey: key.stringValue)
    }
    
    func getData<T>(forKey key: String) throws -> T {
        if let data = data.object(forKey: key) as? T {
            return data
        } else {
            throw "Cannot decode \(data.self) to \(T.self)"
        }
    }
    
    func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
        if T.self is UserDefaultsNative.Type {
            return try getData(forKey: key)
        } else {
            return try T(from: _Decoder(from: getData(forKey: key)))
        }
    }
    
    func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        return .init(_KeyedDecodingContainerProtocol<NestedKey>(from: try getData(forKey: key)))
    }
    
    func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        return _UnkeyedDecodingContainer(from: try getData(forKey: key))
    }
    
    func superDecoder() throws -> Decoder {
        return _Decoder(from: try getData(forKey: "super"))
    }
    
    func superDecoder(forKey key: Key) throws -> Decoder {
        return _Decoder(from: try getData(forKey: key))
    }
    
    func contains(_ key: Key) -> Bool {
        return data.object(forKey: key.stringValue) != nil
    }
    
    func decodeNil(forKey key: Key) throws -> Bool {
        return try getData(forKey: key) == NSNull()
    }
    
    func decode(_ type: Bool.Type, forKey key: Key) throws -> Bool {
        return try getData(forKey: key)
    }
    
    func decode(_ type: String.Type, forKey key: Key) throws -> String {
        return try getData(forKey: key)
    }
    
    func decode(_ type: Double.Type, forKey key: Key) throws -> Double {
        return try getData(forKey: key)
    }
    
    func decode(_ type: Float.Type, forKey key: Key) throws -> Float {
        return try getData(forKey: key)
    }
    
    func decode(_ type: Int.Type, forKey key: Key) throws -> Int {
        return try getData(forKey: key)
    }
    
    func decode(_ type: Int8.Type, forKey key: Key) throws -> Int8 {
        return try getData(forKey: key)
    }
    
    func decode(_ type: Int16.Type, forKey key: Key) throws -> Int16 {
        return try getData(forKey: key)
    }
    
    func decode(_ type: Int32.Type, forKey key: Key) throws -> Int32 {
        return try getData(forKey: key)
    }
    
    func decode(_ type: Int64.Type, forKey key: Key) throws -> Int64 {
        return try getData(forKey: key)
    }
    
    func decode(_ type: UInt.Type, forKey key: Key) throws -> UInt {
        return try getData(forKey: key)
    }
    
    func decode(_ type: UInt8.Type, forKey key: Key) throws -> UInt8 {
        return try getData(forKey: key)
    }
    
    func decode(_ type: UInt16.Type, forKey key: Key) throws -> UInt16 {
        return try getData(forKey: key)
    }
    
    func decode(_ type: UInt32.Type, forKey key: Key) throws -> UInt32 {
        return try getData(forKey: key)
    }
    
    func decode(_ type: UInt64.Type, forKey key: Key) throws -> UInt64 {
        return try getData(forKey: key)
    }
}
