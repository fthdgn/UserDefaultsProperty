import Foundation

class UserDefaultsEncoder {
    static func encode<T: Encodable>(_ value: T) throws -> Any? {
        if T.self is UserDefaultsNative.Type {
            return value
        } else {
            let data = UserDefaultsEncoderData()
            let encoder = _Encoder(to: data, codingPath: [])
            try value.encode(to: encoder)
            return data.data
        }
    }
}

class UserDefaultsEncoderData {
    private(set) var data: Any?
    
    func encode(key codingKey: [CodingKey], value: Any?) {
        self.data = self.updateData(data: self.data, key: codingKey, value: value)
    }
    
    private func updateData(data: Any?, key codingKey: [CodingKey], value: Any?) -> Any? {
        if let firstCodingKey = codingKey.first {
            if let intKey = (firstCodingKey as? _UnkeyedEncodingContainer.IndexedCodingKey)?.intValue {
                let array: NSMutableArray = data as? NSMutableArray ?? .init()
                let currentElement = array.count > intKey ? array.object(at: intKey) : nil
                let updatedElement = self.updateData(data: currentElement, key: .init(codingKey[1...]), value: value)
                array.insert(updatedElement ?? NSNull(), at: intKey)
                return array
            } else {
                let stringKey = firstCodingKey.stringValue
                let dictionary: NSMutableDictionary = (data as? NSMutableDictionary) ?? .init()
                let currentElement = dictionary.object(forKey: stringKey)
                let updatedElement = self.updateData(data: currentElement, key: .init(codingKey[1...]), value: value)
                dictionary.setObject(updatedElement ?? NSNull(), forKey: stringKey as NSCopying)
                return dictionary
            }
        } else {
            return value
        }
    }
}

struct _Encoder: Encoder {
    private let data: UserDefaultsEncoderData
    let userInfo: [CodingUserInfoKey: Any] = [:]
    let codingPath: [CodingKey]
    
    init(to data: UserDefaultsEncoderData, codingPath: [CodingKey]) {
        self.data = data
        self.codingPath = codingPath
    }
    
    func container<Key: CodingKey>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> {
        return KeyedEncodingContainer(_KeyedEncodingContainerProtocol(to: self.data, codingPath: self.codingPath))
    }
    
    func unkeyedContainer() -> UnkeyedEncodingContainer {
        return _UnkeyedEncodingContainer(to: self.data, codingPath: self.codingPath)
    }
    
    func singleValueContainer() -> SingleValueEncodingContainer {
        return _SingleValueEncodingContainer(to: self.data, codingPath: self.codingPath)
    }
}
