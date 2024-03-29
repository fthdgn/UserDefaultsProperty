@testable import UserDefaultsProperty
import XCTest

final class PrimitiveTests: XCTestCase {
    func testString() {
        UserDefaults.standard.removePersistentDomain(forName: "testString")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testString")!
            
            var property: String?
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
        let value: String = "value"
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? String, value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testDate() {
        UserDefaults.standard.removePersistentDomain(forName: "testDate")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDate")!
            
            var property: Date?
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
        let value: Date = .init(timeIntervalSinceNow: 100)
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? Date, value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testData() {
        UserDefaults.standard.removePersistentDomain(forName: "testData")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testData")!
            
            var property: Data?
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
        let value: Data = .init([0])
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? Data, value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
    
    func testInt() {
        UserDefaults.standard.removePersistentDomain(forName: "testInt")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testInt")!
            
            var property: Int?
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
        let value: Int = 50
        let myDefaults = MyDefaults()
        
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? Int, value)
        
        myDefaults.property = nil
        XCTAssertEqual(myDefaults.property, nil)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
    }
}
