import Foundation

struct _SingleValueDecodingContainer: SingleValueDecodingContainer {
    private let data: Any
    let codingPath: [CodingKey] = []
    
    init(from data: Any) {
        self.data = data
    }
    
    func decode<T>(_ type: T.Type) throws -> T where T: Decodable {
        if T.self is UserDefaultsNative.Type {
            return try cast(data)
        } else {
            return try T(from: _Decoder(from: data))
        }
    }
    
    func decodeNil() -> Bool {
        return data as? NSObject == NSNull()
    }
    
    func decode(_ type: Bool.Type) throws -> Bool {
        return try cast(data)
    }
    
    func decode(_ type: String.Type) throws -> String {
        return try cast(data)
    }
    
    func decode(_ type: Double.Type) throws -> Double {
        return try cast(data)
    }
    
    func decode(_ type: Float.Type) throws -> Float {
        return try cast(data)
    }
    
    func decode(_ type: Int.Type) throws -> Int {
        return try cast(data)
    }
    
    func decode(_ type: Int8.Type) throws -> Int8 {
        return try cast(data)
    }
    
    func decode(_ type: Int16.Type) throws -> Int16 {
        return try cast(data)
    }
    
    func decode(_ type: Int32.Type) throws -> Int32 {
        return try cast(data)
    }
    
    func decode(_ type: Int64.Type) throws -> Int64 {
        return try cast(data)
    }
    
    func decode(_ type: UInt.Type) throws -> UInt {
        return try cast(data)
    }
    
    func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try cast(data)
    }
    
    func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try cast(data)
    }
    
    func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try cast(data)
    }
    
    func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try cast(data)
    }
}
