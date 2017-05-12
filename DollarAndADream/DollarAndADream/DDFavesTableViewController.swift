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
    
    var namesArray = ["FirstLead", "KindredKids", "Welstar", "MmmHmm", "Greatone"]
    var sinceArray = ["May 3, 2017", "Apr 30, 2017", "Apr 27, 2017", "Apr 27, 2017", "Apr 27, 2017"]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("X")
        
//        var image = UIImage(named: "plus")
//        image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.plain, target: self, action: #selector(DDFavesTableViewController.addFavorite))
        
        let addFaveBtn = UIBarButtonItem(title: "+", style: UIBarButtonItemStyle.done, target: self, action: #selector(DDFavesTableViewController.addFavorite))
        self.navigationItem.rightBarButtonItem = addFaveBtn

        
        self.tableView.separatorStyle = .none
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    func addFavorite() {
        let alertController = UIAlertController(title: "Please", message: "enter username", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = "username"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            self.namesArray.append((alertController.textFields?.first?.text!)!)
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, yyyy"

            let myString = formatter.string(from: Date())
            self.sinceArray.append(myString)
            
            alertController.dismiss(animated: true, completion: nil)
            self.tableView.reloadData()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func schedulePayTapped(_ sender: UIButton) {
        /*Grab the superView of the sender and cast it to a DDFavesCell; then get the indexPath of that Cell from the tableView and grab that Favorite from the datasource array and prefill the modal for scheduling a payment with his/her info*/
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteItem (_ sender: UIButton) {
        let cell  = sender.superview!.superview!.superview!.superview as! DDFavesCell
        let idxPath = tableView.indexPath(for: cell)
        
        namesArray.remove(at: idxPath!.row)
        sinceArray.remove(at: idxPath!.row)
        tableView.deleteRows(at: [idxPath!], with: .fade)
        
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
        return namesArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavesCell", for: indexPath) as! DDFavesCell
        cell.delegate = self
        
        cell.nameLabel.text = namesArray[indexPath.row]
        cell.dateLabel.text = "Since: \(sinceArray[indexPath.row])"
        cell.deleteBtn?.addTarget(self, action: #selector(DDFavesTableViewController.deleteItem), for: .touchUpInside)

        return cell
    }

}
