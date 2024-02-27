@testable import UserDefaultsProperty
import XCTest

final class PrimitiveWithDefaultTests: XCTestCase {
    func testString() {
        UserDefaults.standard.removePersistentDomain(forName: "testStringDefault")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testStringDefault")!
            
            var property: String
            {
                get {
                    return _uf_get(
                        forKey: "property",
                        withFallback: "default"
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
        
        XCTAssertEqual(myDefaults.property, "default")
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? String, value)
    }
    
    func testDate() {
        UserDefaults.standard.removePersistentDomain(forName: "testDateDefault")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDateDefault")!
            
            var property: Date
            {
                get {
                    return _uf_get(
                        forKey: "property",
                        withFallback: .distantFuture
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
        
        XCTAssertEqual(myDefaults.property, .distantFuture)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? Date, value)
    }
    
    func testData() {
        UserDefaults.standard.removePersistentDomain(forName: "testDataDefault")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testDataDefault")!
            
            var property: Data
            {
                get {
                    return _uf_get(
                        forKey: "property",
                        withFallback: .init(base64Encoded: "nDs=")!
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
        
        XCTAssertEqual(myDefaults.property, .init(base64Encoded: "nDs=")!)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? Data, value)
    }
    
    func testInt() {
        UserDefaults.standard.removePersistentDomain(forName: "testIntDefault")
        class MyDefaults: UserDefaultsProvider {
            var userDefaults = UserDefaults(suiteName: "testIntDefault")!
            
            var property: Int
            {
                get {
                    return _uf_get(
                        forKey: "property",
                        withFallback: 123
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
        
        XCTAssertEqual(myDefaults.property, 123)
        XCTAssertTrue(myDefaults.userDefaults.object(forKey: "property") == nil)
        
        myDefaults.property = value
        XCTAssertEqual(myDefaults.property, value)
        XCTAssertEqual(myDefaults.userDefaults.object(forKey: "property") as? Int, value)
    }
}
