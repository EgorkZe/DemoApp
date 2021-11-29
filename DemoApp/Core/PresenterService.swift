//
//  PresenterService.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

/// Simple mechanism to route
final class PresenterService: SingletonProtocol {
    
    // MARK: - PRIVATE FIELDS
    
    private let container: ContainerProtocol
    private var topViewController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        return findTopViewController(in: keyWindow?.rootViewController)
    }
    
    required init(container: ContainerProtocol, args: Void) {
        self.container = container
    }
    
    func present<VC: UIViewController & HaveViewModelProtocol>(
        _ viewController: VC.Type,
        args: VC.ViewModel.Arguments) where VC.ViewModel: ResolvableProtocol {
        /// Resolve and present
        let vc = VC()
        vc.viewModel = container.resolve(args: args)
        
        topViewController?.present(vc, animated: true, completion: nil)
    }
    
    func dismiss() {
        topViewController?.dismiss(animated: true, completion: nil)
    }

    // MARK: - PRIVATE METHODS
    
    private func findTopViewController(in controller: UIViewController?) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return findTopViewController(in: navigationController.topViewController)
        } else if let tabController = controller as? UITabBarController,
            let selected = tabController.selectedViewController {
            return findTopViewController(in: selected)
        } else if let presented = controller?.presentedViewController {
            return findTopViewController(in: presented)
        }
        return controller
    }
}

extension PresenterService {
    func present<VC: UIViewController & HaveViewModelProtocol>(
        _ viewController: VC.Type) where VC.ViewModel: ResolvableProtocol, VC.ViewModel.Arguments == Void {
        
        present(viewController, args: ())
    }
}
