@testable import UserDefaultsProperty
import XCTest

final class StringKeyDictionaryTests: XCTestCase {
    func testStringDictionary() {
        UserDefaults.standard.removePersistentDomain(forName: "testStringDictionary")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testStringArray")!
            
            var property: [String: String]?
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
        let value: [String: String] = ["key1": "value1", "key2": "value2"]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? [String: String], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testDateDictionary() {
        UserDefaults.standard.removePersistentDomain(forName: "testDateDictionary")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDateDictionary")!
            
            var property: [String: Date]?
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
        let value: [String: Date] = ["key1": .init(timeIntervalSinceNow: 100), "key2": .init(timeIntervalSinceNow: 200)]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? [String: Date], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testDataDictionary() {
        UserDefaults.standard.removePersistentDomain(forName: "testDataDictionary")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDataDictionary")!
            
            var property: [String: Data]?
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
        let value: [String: Data] = ["key1": .init([0]), "key2": .init([1])]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? [String: Data], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testIntDictionary() {
        UserDefaults.standard.removePersistentDomain(forName: "testIntArray")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testIntArray")!
            
            var property: [String: Int]?
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
        let value: [String: Int] = ["key1": 50, "key2": 70]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? [String: Int], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
}
