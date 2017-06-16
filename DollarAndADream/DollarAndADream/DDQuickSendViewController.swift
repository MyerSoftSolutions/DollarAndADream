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
        super.sendPressed(sender)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissQuickSendNotification"), object: nil)
    }
}
