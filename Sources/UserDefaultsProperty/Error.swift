import Foundation

enum UserDefaultsPropertyError: Error {
    case cast(value: Any, type: Any)
}
