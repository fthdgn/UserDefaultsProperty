@testable import UserDefaultsProperty
import XCTest

final class CacheTests: XCTestCase {
    func testCacheStringArray() {
        UserDefaults.standard.removePersistentDomain(forName: "testCacheStringArray")
        class MyDefaults: UserDefaultsProvider, UserDefaultsCacheProvider {
            var userDefaults = UserDefaults(suiteName: "testCacheStringArray")!
            let cache = UserDefaultsPropertyCache()
            
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
}
