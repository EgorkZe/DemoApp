//
//  UIViewController+Alert.swift
//  DemoApp
//
//  Created by Egor Shashkov on 28.11.2021.
//

import UIKit

extension UIViewController {
    
    /// Simple method to show alert with completion block
    func showAlert(title: String, message: String, completion: @escaping ()->Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            completion()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}
