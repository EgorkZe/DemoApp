//
//  Event.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

final class Event<Args> {
    // There is live subs and handlers
    private var handlers: [Weak<AnyObject>: (Args) -> Void] = [:]
    
    init() {
        
    }

    func subscribe<Subscriber: AnyObject>(
        _ subscriber: Subscriber,
        handler: @escaping (Subscriber, Args) -> Void) {
        
        // Making a key
        let key = Weak<AnyObject>(subscriber)
        // Remove died handlers
        handlers = handlers.filter { $0.key.isAlive }
        // Make event handler
        handlers[key] = {
            [weak subscriber] args in
            // Capture subscriber with weak pointer
            guard let subscriber = subscriber else { return }
            handler(subscriber, args)
        }
    }

    func unsubscribe(_ subscriber: AnyObject) {
        // Unsubscribe by deleting the object
        let key = Weak<AnyObject>(subscriber)
        handlers[key] = nil
    }
    
    func raise(_ args: Args) {
        // Get list of handlers
        let aliveHandlers = handlers.filter { $0.key.isAlive }
        // Run handlers for all subscribers
        aliveHandlers.forEach { $0.value(args) }
    }
    
}

extension Event where Args == Void {
    func subscribe<Subscriber: AnyObject>(
        _ subscriber: Subscriber,
        handler: @escaping (Subscriber) -> Void) {

        subscribe(subscriber) { this, _ in
            handler(this)
        }
    }

    func raise() {
        raise(())
    }
    
}
