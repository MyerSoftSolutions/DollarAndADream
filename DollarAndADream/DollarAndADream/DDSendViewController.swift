//
//  DDSendViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 4/26/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDSendViewController: UIViewController, UISearchBarDelegate {
    
    var amount = 1.00

    @IBOutlet var amountSlider: UISlider!
    @IBOutlet var sendBtn: UIButton!
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var dollarLabel: UILabel!
    @IBOutlet var centsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("X")
        self.amountSlider.minimumValue = 0.01
        
        self.searchBar.returnKeyType = UIReturnKeyType.done

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    @IBAction func sendPressed(_ sender: Any) {
        if searchBar.text?.characters.count != 0 {
            if self.amount != 1.00 {
                let amt = Int(self.amount * 100)
                let alertController = UIAlertController(title: "Send \(String(format: "%d", amt))¢ to \(String(describing: searchBar.text!))?", message: "", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    alertController.dismiss(animated: true, completion: nil)
                    self.navigationController?.dismiss(animated: true, completion: nil)
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
                    self.navigationController?.dismiss(animated: true, completion: nil)

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
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        self.amount = Double(sender.value)
        if self.amount != 1.00 {
            let amt = Int(self.amount * 100)
            self.sendBtn.setTitle("SEND \(String(format: "%d", amt))¢", for: .normal)
            self.dollarLabel.text = "0"
            
            if self.amount < 0.1 {
                self.centsLabel.text = String(format: "0%@", String(format: "%d", amt))
            } else {
                self.centsLabel.text = String(format: "%d", amt)
            }
            
            if self.sendBtn.currentTitle == "SEND 0¢" {
                self.sendBtn.setTitle("SEND 1¢", for: .normal)
                self.centsLabel.text = "01"

                self.sendBtn.isEnabled = false
            } else {
                self.sendBtn.isEnabled = true
            }
            
        } else {
            self.sendBtn.setTitle("SEND $\(String(format: "%.2f", self.amount))", for: .normal)
            self.centsLabel.text = "00"
            self.dollarLabel.text = "1"

        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
