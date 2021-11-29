//
//  Observable.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

@propertyWrapper
struct Observable<T> {
    let projectedValue = Event<T>()
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    var wrappedValue: T {
        didSet {
            projectedValue.raise(wrappedValue)
        }
    }
}
