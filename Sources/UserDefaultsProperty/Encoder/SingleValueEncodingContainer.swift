import Foundation

struct _SingleValueEncodingContainer: SingleValueEncodingContainer {
    let data: UserDefaultsEncoderData
    let codingPath: [CodingKey]
    
    init(to data: UserDefaultsEncoderData, codingPath: [CodingKey]) {
        self.data = data
        self.codingPath = codingPath
    }
    
    func encode<T>(_ value: T) throws where T: Encodable {
        if T.self is UserDefaultsNative.Type {
            data.encode(key: codingPath, value: value)
        } else {
            try value.encode(to: _Encoder(to: data, codingPath: codingPath))
        }
    }
    
    func encodeNil() throws {
        data.encode(key: codingPath, value: NSNull())
    }
    
    func encode(_ value: Bool) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: String) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: Double) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: Float) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: Int) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: Int8) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: Int16) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: Int32) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: Int64) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: UInt) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: UInt8) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: UInt16) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: UInt32) throws {
        data.encode(key: codingPath, value: value)
    }
    
    func encode(_ value: UInt64) throws {
        data.encode(key: codingPath, value: value)
    }
}
