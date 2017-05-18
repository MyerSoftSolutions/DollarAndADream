//
//  DDSettingsTableViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 5/8/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDSettingsCell : UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var toggleSwitch: UISwitch!
}


class DDSettingsTableViewController: UITableViewController {

    let namesArray = ["Switch to Giver", "Show Account Balance", "Show Contact Information", ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("X")
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleTapped(_ sender: UISwitch) {
        let cell = sender.superview?.superview as! DDSettingsCell
        let idxPath = tableView.indexPath(for: cell)
        
        switch idxPath!.row {
        case 1:
            if sender.isOn {
                UserDefaults.standard.set(true, forKey: "showBalance")
            } else {
                UserDefaults.standard.set(false, forKey: "showBalance")
            }
            UserDefaults.standard.synchronize()
            break
        case 2:
            if sender.isOn {
                UserDefaults.standard.set(true, forKey: "showInfo")
            } else {
                UserDefaults.standard.set(false, forKey: "showInfo")
            }
            UserDefaults.standard.synchronize()
            break
        default:
            break
        }
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! DDSettingsCell
        cell.titleLabel.text = namesArray[indexPath.row]
        
        if indexPath.row == 1 {
            let opened : Bool = UserDefaults.standard.bool(forKey: "showBalance" )
            cell.toggleSwitch.isOn = opened
        } else if indexPath.row == 2 {
        
        }

        // Configure the cell...

        return cell
    }

}
