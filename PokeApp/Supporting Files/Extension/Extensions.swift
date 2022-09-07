//
//  Extensions.swift
//  PokeApp
//
//  Created by Christian Castro on 07/09/22.
//

import UIKit

extension UIAlertController {
    class func customAlert(title: String, message: String?, controller: UIViewController, action: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .cancel, handler: action)
        alert.addAction(confirmAction)
        controller.present(alert, animated: true)
    }
}
