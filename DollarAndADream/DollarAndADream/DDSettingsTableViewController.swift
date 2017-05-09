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

    let namesArray = ["Show Account Balance", "Show Contact Information", "Switch to Giver"]
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
        
    }
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! DDSettingsCell
        cell.titleLabel.text = namesArray[indexPath.row]
        

        // Configure the cell...

        return cell
    }

}
