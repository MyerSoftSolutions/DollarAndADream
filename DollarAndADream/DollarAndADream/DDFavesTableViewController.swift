//
//  DDFavesTableViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 5/3/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDFavesCell : PKSwipeTableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    var deleteBtn : UIButton?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addRightViewInCell()
    }
    
    func addRightViewInCell() {
        //Create a view that will display when user swipe the cell in right
        let viewCall = UIView()
        viewCall.backgroundColor = UIColor.orange
        viewCall.frame = CGRect(x: 0, y: 0, width: 68.0, height: self.frame.size.height)
        
        let bigBtn = UIButton(type: UIButtonType.custom)
        bigBtn.frame = viewCall.frame
        bigBtn.backgroundColor = UIColor.clear
        self.deleteBtn = bigBtn
        
        let dismissLabel = UILabel()
        dismissLabel.text = "Remove"
        dismissLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 12.0)
        dismissLabel.textColor = UIColor.white
        dismissLabel.frame =  CGRect(x: 12, y:13, width: 50, height: 20)
        //        dismissLabel.center = viewCall.center
        dismissLabel.backgroundColor = UIColor.orange
        
        bigBtn.addSubview(dismissLabel)
        viewCall.addSubview(bigBtn)

        
        //Call the super addRightOptions to set the view that will display while swiping
        super.addRightOptionsView(viewCall)
    }

}

class DDFavesTableViewController: UITableViewController, PKSwipeCellDelegateProtocol {

    fileprivate var oldStoredCell : DDFavesCell?
    
    let namesArray = ["FirstLead", "KindredKids", "Welstar"]
    let sinceArray = ["May 3, 2017", "Apr 30, 2017", "April 27, 2017"]


    override func viewDidLoad() {
        super.viewDidLoad()

        self.createCustomBackButton("X")

        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }

    @IBAction func schedulePayTapped(_ sender: UIButton) {
        /*Grab the superView of the sender and cast it to a DDFavesCell; then get the indexPath of that Cell from the tableView and grab that Favorite from the datasource array and prefill the modal for scheduling a payment with his/her info*/
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SwipeCell Delegate Methods
    func swipeBeginInCell(_ cell: PKSwipeTableViewCell) {
        
        oldStoredCell = cell as? DDFavesCell
    }
    
    func swipeDoneOnPreviousCell() -> PKSwipeTableViewCell? {
        guard let cell = oldStoredCell else {
            return nil
        }
        return cell
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavesCell", for: indexPath) as! DDFavesCell
        cell.delegate = self
        
        cell.nameLabel.text = namesArray[indexPath.row]
        cell.dateLabel.text = "Since: \(sinceArray[indexPath.row])"

        return cell
    }

}
