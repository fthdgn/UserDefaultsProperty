@testable import UserDefaultsProperty
import XCTest

final class IntKeyDictionaryTests: XCTestCase {
    func testIntDictionary() {
        UserDefaults.standard.removePersistentDomain(forName: "testIntDictionary")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testIntDictionary")!
            
            var property: [Int: String]?
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
        let value: [Int: String] = [1: "value1", 2: "value2"]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(self.convertArrayToDictionary(myDefaults.userDefaults.object(forKey: "property") as! NSDictionary), value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func convertArrayToDictionary<Value>(_ value: NSDictionary) -> [Int: Value] {
        var dictionary: [Int: Value] = [:]
        for key in value.allKeys {
            dictionary[Int(key as! String)!] = (value[key] as! Value)
        }
        return dictionary
    }
}
