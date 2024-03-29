@testable import UserDefaultsProperty
import XCTest

final class CodableTests: XCTestCase {
    func testStringCodable() {
        UserDefaults.standard.removePersistentDomain(forName: "testStringCodable")
        struct Holder: Codable, Equatable {
            let single: String
            let array: [String]
            let dictionary: [String: String]
        }
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testStringCodable")!
            
            var property: Holder?
            {
                get {
                    return _uf_get(
                        forKey: "property",
                        withFallback: nil
                    )
                }
                set {
                    _uf_set(
                        value: newValue,
                        forKey: "property"
                    )
                }
            }
        }
        let value: Holder = .init(
            single: "value",
            array: ["value1", "value2"],
            dictionary: ["key1": "value1", "key2": "value2"]
        )
        let valueDictionary: NSDictionary = [
            "single": value.single,
            "array": value.array,
            "dictionary": value.dictionary,
        ]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? NSDictionary, valueDictionary)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testDateCodable() {
        UserDefaults.standard.removePersistentDomain(forName: "testDateCodable")
        struct Holder: Codable, Equatable {
            let single: Date
            let array: [Date]
            let dictionary: [String: Date]
        }
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDateCodable")!
            
            var property: Holder?
            {
                get {
                    return _uf_get(
                        forKey: "property",
                        withFallback: nil
                    )
                }
                set {
                    _uf_set(
                        value: newValue,
                        forKey: "property"
                    )
                }
            }
        }
        let value: Holder = .init(
            single: .init(timeIntervalSinceNow: 100),
            array: [.init(timeIntervalSinceNow: 100), .init(timeIntervalSinceNow: 200)],
            dictionary: ["key1": .init(timeIntervalSinceNow: 100), "key2": .init(timeIntervalSinceNow: 200)]
        )
        let valueDictionary: NSDictionary = [
            "single": value.single,
            "array": value.array,
            "dictionary": value.dictionary,
        ]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? NSDictionary, valueDictionary)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testDataCodable() {
        UserDefaults.standard.removePersistentDomain(forName: "testDataCodable")
        struct Holder: Codable, Equatable {
            let single: Data
            let array: [Data]
            let dictionary: [String: Data]
        }
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDataCodable")!
            
            var property: Holder?
            {
                get {
                    return _uf_get(
                        forKey: "property",
                        withFallback: nil
                    )
                }
                set {
                    _uf_set(
                        value: newValue,
                        forKey: "property"
                    )
                }
            }
        }
        let value: Holder = .init(
            single: .init([1]),
            array: [.init([2]), .init([4])],
            dictionary: ["key1": .init([5]), "key2": .init([6])]
        )
        let valueDictionary: NSDictionary = [
            "single": value.single,
            "array": value.array,
            "dictionary": value.dictionary,
        ]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? NSDictionary, valueDictionary)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testIntCodable() {
        UserDefaults.standard.removePersistentDomain(forName: "testIntCodable")
        struct Holder: Codable, Equatable {
            let single: Int
            let array: [Int]
            let dictionary: [String: Int]
        }
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testIntCodable")!
            
            var property: Holder?
            {
                get {
                    return _uf_get(
                        forKey: "property",
                        withFallback: nil
                    )
                }
                set {
                    _uf_set(
                        value: newValue,
                        forKey: "property"
                    )
                }
            }
        }
        let value: Holder = .init(
            single: 1,
            array: [1, 2],
            dictionary: ["key1": 5, "key2": 10]
        )
        let valueDictionary: NSDictionary = [
            "single": value.single,
            "array": value.array,
            "dictionary": value.dictionary,
        ]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? NSDictionary, valueDictionary)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
}
