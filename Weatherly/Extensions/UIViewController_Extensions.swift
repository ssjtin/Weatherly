//
//  UIViewController_Extensions.swift
//  ReadingBuddy
//
//  Created by Hoang Luong on 21/2/19.
//  Copyright © 2019 Hoang Luong. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //Simplify method for adding and removing child view controllers
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func presentAlert(title: String, message: String, actionTitle: String = "Confirm", handler: @autoclosure @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: actionTitle, style: .default) { (action) in
            handler()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
