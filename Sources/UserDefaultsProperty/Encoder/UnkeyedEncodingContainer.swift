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
        self.count += 1
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
            self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
        } else {
            try value.encode(to: _Encoder(to: self.data, codingPath: self.codingPath + [self.nextIndexedKey()]))
        }
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        return KeyedEncodingContainer(_KeyedEncodingContainerProtocol(to: self.data, codingPath: self.codingPath + [self.nextIndexedKey()]))
    }
    
    mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        return _UnkeyedEncodingContainer(to: self.data, codingPath: self.codingPath + [self.nextIndexedKey()])
    }
    
    mutating func superEncoder() -> Encoder {
        return _Encoder(to: self.data, codingPath: self.codingPath + [self.nextIndexedKey()])
    }
    
    mutating func encode(_ value: String) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Double) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Float) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int8) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int16) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int32) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Int64) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt8) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt16) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt32) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: UInt64) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encode(_ value: Bool) throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: value)
    }
    
    mutating func encodeNil() throws {
        self.data.encode(key: self.codingPath + [self.nextIndexedKey()], value: NSNull())
    }
}
