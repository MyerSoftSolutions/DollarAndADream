//
//  DDReceivedTableViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 5/3/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDReceivedCell : UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
}

class DDReceivedTableViewController: UITableViewController {
    
    let namesArray = ["JamesK", "Ascend20", "WellingtonD", "XavierE"]
    let dateArray = ["May 3, 2017", "May 3, 2017", "April 30, 2017", "April 30, 2017"]
    
    let priceArray = ["$1.00", "89¢", "50¢", "$1.00"]


    override func viewDidLoad() {
        super.viewDidLoad()

        self.createCustomBackButton("X")
        
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedCell", for: indexPath) as! DDReceivedCell

        cell.nameLabel.text = namesArray[indexPath.row]
        cell.dateLabel.text = dateArray[indexPath.row]
        cell.amountLabel.text = priceArray[indexPath.row]
        
        return cell
    }
 

}
