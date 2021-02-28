@testable import UserDefaultsProperty
import XCTest

final class ArrayTests: XCTestCase {
    func testStringArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testStringArray")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testStringArray")!
            
            @UserDefaultsProperty(key: "property")
            var property: [String]?
        }
        let value: [String] = ["value1", "value2"]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.value(forKey: "property") as? [String], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
    }
    
    func testDateArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testDateArray")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDateArray")!
            
            @UserDefaultsProperty(key: "property")
            var property: [Date]?
        }
        let value: [Date] = [.init(timeIntervalSinceNow: 100), .init(timeIntervalSinceNow: 200)]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.value(forKey: "property") as? [Date], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
    }
    
    func testDataArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testDataArray")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDataArray")!
            
            @UserDefaultsProperty(key: "property")
            var property: [Data]?
        }
        let value: [Data] = [.init([0]), .init([1])]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.value(forKey: "property") as? [Data], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
    }
    
    func testIntArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testIntArray")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testIntArray")!
            
            @UserDefaultsProperty(key: "property")
            var property: [Int]?
        }
        let value: [Int] = [50, 70]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.value(forKey: "property") as? [Int], value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
    }
}
