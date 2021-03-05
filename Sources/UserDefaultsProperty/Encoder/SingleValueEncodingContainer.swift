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
            self.data.encode(key: self.codingPath, value: value)
        } else {
            try value.encode(to: _Encoder(to: self.data, codingPath: self.codingPath))
        }
    }
    
    func encodeNil() throws {
        self.data.encode(key: self.codingPath, value: NSNull())
    }
    
    func encode(_ value: Bool) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: String) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: Double) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: Float) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: Int) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: Int8) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: Int16) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: Int32) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: Int64) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: UInt) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: UInt8) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: UInt16) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: UInt32) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
    
    func encode(_ value: UInt64) throws {
        self.data.encode(key: self.codingPath, value: value)
    }
}
