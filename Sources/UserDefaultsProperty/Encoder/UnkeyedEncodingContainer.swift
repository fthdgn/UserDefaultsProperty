import Foundation

struct _UnkeyedEncodingContainer: UnkeyedEncodingContainer {
    let data: UserDefaultsEncoderData
    let codingPath: [CodingKey]
    
    init(to data: UserDefaultsEncoderData, codingPath: [CodingKey]) {
        self.data = data
        self.codingPath = codingPath
    }
    
    private(set) var count: Int = 0
    
    private mutating func nextIndexedKey() -> CodingKey {
        let nextCodingKey = IndexedCodingKey(intValue: count)!
        count += 1
        return nextCodingKey
    }
    
    struct IndexedCodingKey: CodingKey {
        let intValue: Int?
        let stringValue: String
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = intValue.description
        }
        
        init?(stringValue: String) {
            return nil
        }
    }
    
    mutating func encode<T>(_ value: T) throws where T: Encodable {
        if T.self is UserDefaultsNative.Type {
            data.encode(key: codingPath + [nextIndexedKey()], value: value)
        } else {
            try value.encode(to: _Encoder(to: data, codingPath: codingPath + [nextIndexedKey()]))
        }
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        return KeyedEncodingContainer(_KeyedEncodingContainerProtocol(to: data, codingPath: codingPath + [nextIndexedKey()]))
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        return _UnkeyedEncodingContainer(to: data, codingPath: codingPath + [nextIndexedKey()])
    }
    
    mutating func superEncoder() -> Encoder {
        return _Encoder(to: data, codingPath: codingPath + [nextIndexedKey()])
    }
    
    mutating func encode(_ value: String) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Double) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Float) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int8) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int16) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int32) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int64) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt8) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt16) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt32) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt64) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Bool) throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: value)
    }
    
    mutating func encodeNil() throws {
        data.encode(key: codingPath + [nextIndexedKey()], value: NSNull())
    }
}
