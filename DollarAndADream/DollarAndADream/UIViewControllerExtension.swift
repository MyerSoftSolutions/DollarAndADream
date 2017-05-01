//
//  UIViewControllerExtension.swift
//  DollarAndADream
//
//  Created by Joel Myers on 5/1/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{

    
    func createCustomBackButton(_ btnTitle: String) {
//        var image = UIImage(named: "menu")
//        image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("showMenu"))
        
        let backBtn = UIBarButtonItem(title: btnTitle, style: UIBarButtonItemStyle.done, target: self, action: #selector(UIViewController.navigationBackButtonClicked))
        self.navigationItem.leftBarButtonItem = backBtn
    }

    func navigationBackButtonClicked() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissThisKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissThisKeyboard() {
        view.endEditing(true)
    }
    
    
}
