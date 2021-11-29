//
//  Resolvable.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

final class ContainerHolder {
    public static var container: ContainerProtocol!
}

@propertyWrapper
struct Resolvable<T: ResolvableProtocol> where T.Arguments == Void {
    private var instance: T?
    init() { }
    
    var wrappedValue: T {
        mutating get {
            if let instance = instance {
                return instance
            }
            let resolved = ContainerHolder.container.resolve() as T
            instance = resolved
            return resolved
        }
    }
}
