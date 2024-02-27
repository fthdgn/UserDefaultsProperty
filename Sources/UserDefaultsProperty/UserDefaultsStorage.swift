import Foundation
import SwiftUI
import Combine

@propertyWrapper
public struct UserDefaultsStorage<U: UserDefaultsProvider, T: Codable>: DynamicProperty {
    public var wrappedValue: T {
        get {
            let data = userDefaultsProvider[keyPath: keyPath]
            return userDefaultsProvider._uf_get(forKey: data.key, withFallback: data.fallback)
        }
        
        nonmutating set {
            let data = userDefaultsProvider[keyPath: keyPath]
            userDefaultsProvider._uf_set(value: newValue, forKey: data.key)
        }
    }
    
    public var projectedValue: Binding<T> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
    
    let userDefaultsProvider: U
    let keyPath: KeyPath<U, UserDefaultsPropertyData<T>>
        
    @ObservedObject private var observer: PublisherObservableObject
    
    public init(_ userDefaultsProvider: U, _ keyPath: KeyPath<U, UserDefaultsPropertyData<T>>) {
        self.userDefaultsProvider = userDefaultsProvider
        self.keyPath = keyPath
        let data = userDefaultsProvider[keyPath: keyPath]
        self.observer = .init(publisher: userDefaultsProvider.changedSubject.filter({$0 == data.key}).map({_ in ()}).eraseToAnyPublisher())
    }
}

final class PublisherObservableObject: ObservableObject {
    
    var subscriber: AnyCancellable?
    
    init(publisher: AnyPublisher<Void, Never>) {
        subscriber = publisher.sink(receiveValue: { [weak self] _ in
            self?.objectWillChange.send()
        })
    }
}
