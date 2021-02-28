import Foundation

func cast<T>(_ value: Any) throws -> T {
    if let value = value as? T {
        return value
    } else {
        throw "Cannot decode \(value.self) to \(T.self)"
    }
}

enum UserDefaultsDecoder {
    static func decode<T>(_ type: T.Type, from data: Any) throws -> T where T: Decodable {
        if T.self is UserDefaultsNative.Type {
            return try cast(data)
        } else {
            return try T(from: _Decoder(from: data))
        }
    }
}

struct _Decoder: Decoder {
    private let data: Any
    let codingPath: [CodingKey] = []
    let userInfo: [CodingUserInfoKey: Any] = [:]
    
    init(from data: Any) {
        self.data = data
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        return .init(_KeyedDecodingContainerProtocol<Key>(from: try cast(data)))
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return _UnkeyedDecodingContainer(from: try cast(data))
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return _SingleValueDecodingContainer(from: data)
    }
}
