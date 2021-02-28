@testable import UserDefaultsProperty
import XCTest

final class IntKeyDictionaryTests: XCTestCase {
    func testIntDictionary() {
        UserDefaults.standard.removePersistentDomain(forName: "testIntDictionary")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testIntDictionary")!
            
            @UserDefaultsProperty(key: "property")
            var property: [Int: String]?
        }
        let value: [Int: String] = [1: "value1", 2: "value2"]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(convertArrayToDictionary(myDefaults.userDefaults.value(forKey: "property") as! NSDictionary), value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
    }
    
    func convertArrayToDictionary<Value>(_ value: NSDictionary) -> [Int: Value] {
        var dictionary: [Int: Value] = [:]
        for key in value.allKeys {
            dictionary[Int(key as! String)!] = (value[key] as! Value)
        }
        return dictionary
    }
}
