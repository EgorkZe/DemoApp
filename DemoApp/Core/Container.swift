//
//  Container.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

enum InstanceScope {
    case perRequst
    case singleton
}

protocol ResolvableProtocol: AnyObject {
    associatedtype Arguments
    
    static var instanceScope: InstanceScope { get }
    init(container: ContainerProtocol, args: Arguments)
}

protocol SingletonProtocol: ResolvableProtocol where Arguments == Void { }
extension SingletonProtocol {
    static var instanceScope: InstanceScope {
        return .singleton
    }
}

protocol PerRequestProtocol: ResolvableProtocol { }
extension PerRequestProtocol {
    static var instanceScope: InstanceScope {
        return .perRequst
    }
}

protocol ContainerProtocol: AnyObject {
    func resolve<T: ResolvableProtocol>(args: T.Arguments) -> T
}

final class Container {
    private var singletons: [ObjectIdentifier: AnyObject] = [:]
    public init() { }
    
    func makeInstance<T: ResolvableProtocol>(args: T.Arguments) -> T {
        return T(container: self, args: args)
    }
}

extension Container: ContainerProtocol {
    public func resolve<T: ResolvableProtocol>(args: T.Arguments) -> T {
        switch T.instanceScope {
        case .perRequst:
            return makeInstance(args: args)
        case .singleton:
            let key = ObjectIdentifier(T.self)
            if let cached = singletons[key], let instance = cached as? T {
                return instance
            } else {
                let instance: T = makeInstance(args: args)
                singletons[key] = instance
                return instance
            }
        }
    }
}

extension ContainerProtocol {
    func resolve<T: ResolvableProtocol>() -> T where T.Arguments == Void {
        return resolve(args: ())
    }
}
