//
//  AppDelegate.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        loadMainView()
        return true
    }
    
    /// Load first controller
    private func loadMainView() {
        let container = Container()
        let vc = ListView()
        vc.viewModel = container.resolve()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}

