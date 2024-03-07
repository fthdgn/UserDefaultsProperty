@testable import UserDefaultsProperty
import XCTest

final class OtherKeyDictionaryTests: XCTestCase {
    func testDateDictionary() {
        UserDefaults.standard.removePersistentDomain(forName: "testDateDictionary")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDateDictionary")!
            
            var property: [Date: String]?
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
        let value: [Date: String] = [.init(timeIntervalSinceNow: 10): "value1", .init(timeIntervalSinceNow: 50): "value2"]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(self.convertArrayToDictionary(myDefaults.userDefaults.object(forKey: "property") as! NSArray), value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func convertArrayToDictionary<Key, Value>(_ array: NSArray) -> [Key: Value] {
        var dictionary: [Key: Value] = [:]
        for i in 0 ..< array.count / 2 {
            dictionary[array.object(at: i * 2) as! Key] = (array.object(at: i * 2 + 1) as! Value)
        }
        return dictionary
    }
}
