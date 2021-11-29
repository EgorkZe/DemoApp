//
//  HaveViewModelProtocol.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//


import Foundation

protocol AnyViewModelProtocol: AnyObject {}

protocol HaveAnyViewModelProtocol: AnyObject {
    var anyViewModel: Any? { get set }
}

protocol HaveViewModelProtocol: HaveAnyViewModelProtocol {
    associatedtype ViewModel
    
    var viewModel: ViewModel? { get set }
    func viewModelChanged()
    func viewModelChanged(_ viewModel: ViewModel)
}

private var viewModelKey: UInt8 = 0

extension HaveViewModelProtocol {
    
    /// Found the view model by associated object and notify if changed
    var anyViewModel: Any? {
        get {
            return objc_getAssociatedObject(self, &viewModelKey)
        }
        set {
            (anyViewModel as? NotifyOnChangedProtocol)?.changed.unsubscribe(self)
            let viewModel = newValue as? ViewModel
            
            objc_setAssociatedObject(self, &viewModelKey, viewModel, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            viewModelChanged()
            if let viewModel = viewModel {
                viewModelChanged(viewModel)
            }
            
            (viewModel as? NotifyOnChangedProtocol)?.changed.subscribe(self) { this in
                this.viewModelChanged()
                if let viewModel = viewModel {
                    this.viewModelChanged(viewModel)
                }
            }
        }
    }
    
    var viewModel: ViewModel? {
        get {
            return anyViewModel as? ViewModel
        }
        set {
            anyViewModel = newValue
        }
    }
    
    func viewModelChanged() {}
    
    func viewModelChanged(_ viewModel: ViewModel) {}
}
