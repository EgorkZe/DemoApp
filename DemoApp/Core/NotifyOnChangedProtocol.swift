//
//  NotifyOnChangedProtocol.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import Foundation

private var changedEventKey: UInt8 = 0

protocol NotifyOnChangedProtocol {
    var changed: Event<Void> { get }
}

extension NotifyOnChangedProtocol {
    var changed: Event<Void> {
        get {
            if let event = objc_getAssociatedObject(self, &changedEventKey) as? Event<Void> {
                return event
            } else {
                let event = Event<Void>()
                objc_setAssociatedObject(self, &changedEventKey, event, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return event
            }
        }
    }
}
