@testable import UserDefaultsProperty
import XCTest

final class OtherKeyDictionaryTests: XCTestCase {
    func testDateDictionary() {
        UserDefaults.standard.removePersistentDomain(forName: "testDateDictionary")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDateDictionary")!
            
            @UserDefaultsProperty(key: "property")
            var property: [Date: String]?
        }
        let value: [Date: String] = [.init(timeIntervalSinceNow: 10): "value1", .init(timeIntervalSinceNow: 50): "value2"]
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(convertArrayToDictionary(myDefaults.userDefaults.value(forKey: "property") as! NSArray), value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.value(forKey: "property") == nil)
    }
    
    func convertArrayToDictionary<Key, Value>(_ array: NSArray) -> [Key: Value] {
        var dictionary: [Key: Value] = [:]
        for i in 0 ..< array.count / 2 {
            dictionary[array.object(at: i * 2) as! Key] = (array.object(at: i * 2 + 1) as! Value)
        }
        return dictionary
    }
}
