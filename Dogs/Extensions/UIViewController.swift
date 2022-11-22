//
//  UIViewController.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

extension UIViewController {

    // apply styling to navigation bar
    func navigationStyle() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    // display a toast message
    func showAlert(_ message: String?, seconds: Double = 3.0){
        guard let message = message else {
            return
        }

        let alert = UIAlertController(title: nil,
                                      message: NSLocalizedString(message, comment: ""),
                                      preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 8
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }

}
