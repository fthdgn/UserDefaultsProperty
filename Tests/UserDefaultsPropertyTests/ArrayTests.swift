@testable import UserDefaultsProperty
import XCTest

final class ArrayTests: XCTestCase {
    func testStringArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testStringArray")
        
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testStringArray")!
            
            var property: [String]?
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
        
        let value: [String] = ["value1", "value2"]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? [String], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testDateArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testDateArray")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDateArray")!
            
            var property: [Date]?
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
        let value: [Date] = [.init(timeIntervalSinceNow: 100), .init(timeIntervalSinceNow: 200)]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? [Date], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testDataArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testDataArray")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDataArray")!
            
            var property: [Data]?
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
        let value: [Data] = [.init([0]), .init([1])]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? [Data], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testIntArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testIntArray")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testIntArray")!
            
            var property: [Int]?
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
        let value: [Int] = [50, 70]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? [Int], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
}
