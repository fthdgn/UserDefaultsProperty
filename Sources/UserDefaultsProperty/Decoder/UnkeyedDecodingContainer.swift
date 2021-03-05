import Foundation

struct _UnkeyedDecodingContainer: UnkeyedDecodingContainer {
    private let data: NSArray
    let codingPath: [CodingKey] = []
    let count: Int?
    var currentIndex: Int
    
    var isAtEnd: Bool {
        return self.currentIndex >= (self.count ?? 0)
    }
    
    init(from data: NSArray) {
        self.data = data
        self.count = data.count
        self.currentIndex = 0
    }
    
    private mutating func getNextData<T>() throws -> T {
        self.currentIndex += 1
        return try cast(self.data.object(at: self.currentIndex - 1))
    }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        if T.self is UserDefaultsNative.Type {
            return try self.getNextData()
        } else {
            return try T(from: _Decoder(from: self.getNextData()))
        }
    }
    
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        return .init(_KeyedDecodingContainerProtocol(from: try self.getNextData()))
    }
    
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return _UnkeyedDecodingContainer(from: try self.getNextData())
    }
    
    mutating func superDecoder() throws -> Decoder {
        return _Decoder(from: try self.getNextData())
    }
    
    mutating func decodeNil() throws -> Bool {
        return try self.getNextData() == NSNull()
    }
    
    mutating func decode(_ type: Bool.Type) throws -> Bool {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: String.Type) throws -> String {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: Double.Type) throws -> Double {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: Float.Type) throws -> Float {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: Int8.Type) throws -> Int8 {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: Int16.Type) throws -> Int16 {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: Int32.Type) throws -> Int32 {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: Int64.Type) throws -> Int64 {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: UInt.Type) throws -> UInt {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try self.getNextData()
    }
    
    mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try self.getNextData()
    }
}
