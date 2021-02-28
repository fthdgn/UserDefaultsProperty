import Foundation

struct _KeyedEncodingContainerProtocol<Key: CodingKey>: KeyedEncodingContainerProtocol {
    private let data: UserDefaultsEncoderData
    let codingPath: [CodingKey]
    
    init(to data: UserDefaultsEncoderData, codingPath: [CodingKey]) {
        self.data = data
        self.codingPath = codingPath
    }
    
    mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
        if T.self is UserDefaultsNative.Type {
            data.encode(key: codingPath + [key], value: value)
        } else {
            try value.encode(to: _Encoder(to: data, codingPath: codingPath + [key]))
        }
    }
    
    mutating func nestedContainer<NestedKey: CodingKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> {
        return KeyedEncodingContainer(_KeyedEncodingContainerProtocol<NestedKey>(to: data, codingPath: codingPath + [key]))
    }
    
    mutating func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
        return _UnkeyedEncodingContainer(to: data, codingPath: codingPath + [key])
    }
    
    mutating func superEncoder() -> Encoder {
        return superEncoder(forKey: Key(stringValue: "super")!)
    }
    
    mutating func superEncoder(forKey key: Key) -> Encoder {
        return _Encoder(to: data, codingPath: codingPath + [key])
    }
    
    mutating func encodeNil(forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: nil)
    }
    
    mutating func encode(_ value: Bool, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: String, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: Double, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: Float, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: Int, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: Int8, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: Int16, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: Int32, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: Int64, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: UInt, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: UInt8, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: UInt16, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: UInt32, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
    
    mutating func encode(_ value: UInt64, forKey key: Key) throws {
        data.encode(key: codingPath + [key], value: value)
    }
}
