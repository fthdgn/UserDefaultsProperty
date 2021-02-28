import Foundation

struct _UnkeyedDecodingContainer: UnkeyedDecodingContainer {
    private let data: NSArray
    let codingPath: [CodingKey] = []
    let count: Int?
    var currentIndex: Int
    
    var isAtEnd: Bool {
        return currentIndex >= (count ?? 0)
    }
    
    init(from data: NSArray) {
        self.data = data
        count = data.count
        currentIndex = 0
    }
    
    private mutating func getNextData<T>() throws -> T {
        currentIndex += 1
        return try cast(data.object(at: currentIndex - 1))
    }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        if T.self is UserDefaultsNative.Type {
            return try getNextData()
        } else {
            return try T(from: _Decoder(from: getNextData()))
        }
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        return .init(_KeyedDecodingContainerProtocol(from: try getNextData()))
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return _UnkeyedDecodingContainer(from: try getNextData())
    }
    
    mutating func superDecoder() throws -> Decoder {
        return _Decoder(from: try getNextData())
    }
    
    mutating func decodeNil() throws -> Bool {
        return try getNextData() == NSNull()
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        return try getNextData()
    }
    
    mutating func decode(_ type: String.Type) throws -> String {
        return try getNextData()
    }
    
    mutating func decode(_ type: Double.Type) throws -> Double {
        return try getNextData()
    }
    
    mutating func decode(_ type: Float.Type) throws -> Float {
        return try getNextData()
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        return try getNextData()
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        return try getNextData()
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        return try getNextData()
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        return try getNextData()
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        return try getNextData()
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        return try getNextData()
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try getNextData()
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try getNextData()
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try getNextData()
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try getNextData()
    }
}
