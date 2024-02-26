import Foundation

protocol UserDefaultsNative {}

extension Date: UserDefaultsNative {}

extension Data: UserDefaultsNative {}

extension Bool: UserDefaultsNative {}

extension String: UserDefaultsNative {}

extension Double: UserDefaultsNative {}

extension Float: UserDefaultsNative {}

extension Int: UserDefaultsNative {}

extension Int8: UserDefaultsNative {}

extension Int16: UserDefaultsNative {}

extension Int32: UserDefaultsNative {}

extension Int64: UserDefaultsNative {}

extension UInt: UserDefaultsNative {}

extension UInt8: UserDefaultsNative {}

extension UInt16: UserDefaultsNative {}

extension UInt32: UserDefaultsNative {}

extension UInt64: UserDefaultsNative {}

extension Array: UserDefaultsNative where Element: UserDefaultsNative {}

extension Dictionary: UserDefaultsNative where Key == String, Value: UserDefaultsNative {}
