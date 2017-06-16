//
//  DDQuickSendViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 6/3/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDQuickSendViewController: DDSendViewController {

    override func viewDidLoad() {
        self.amountSlider.minimumValue = 0.01
        
        self.searchBar.returnKeyType = UIReturnKeyType.done
        let opened : Bool = UserDefaults.standard.bool(forKey: "showBalance" )
        self.balanceLabel.isHidden = !opened
    }

    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func sendPressed(_ sender: Any) {
        if searchBar.text?.characters.count != 0 {
            if self.amount != 1.00 {
                let amt = Int(self.amount * 100)
                let alertController = UIAlertController(title: "Send \(String(format: "%d", amt))¢ to \(String(describing: searchBar.text!))?", message: "", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    alertController.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissQuickSendNotification"), object: nil)
                }
                
                let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    alertController.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(noAction)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Send $\(String(format: "%.2f", self.amount)) to \(String(describing: searchBar.text!))?", message: "", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    alertController.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissQuickSendNotification"), object: nil)
                    
                }
                
                let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    alertController.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(noAction)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
}
