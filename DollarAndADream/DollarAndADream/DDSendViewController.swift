//
//  DDSendViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 4/26/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDSendViewController: UIViewController {
    
    var amount = 0.89

    @IBOutlet var amountSlider: UISlider!
    @IBOutlet var sendBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("X")
        self.amountSlider.minimumValue = 0.01

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        
        self.amount = Double(sender.value)
        if self.amount != 1.00 {
            let amt = Int(self.amount * 100)
            self.sendBtn.setTitle("SEND \(String(format: "%d", amt))¢", for: .normal)
            if self.sendBtn.currentTitle == "SEND 0¢" {
                self.sendBtn.setTitle("SEND 1¢", for: .normal)
                self.sendBtn.isEnabled = false
            } else {
                self.sendBtn.isEnabled = true

            }
        } else {
            self.sendBtn.setTitle("SEND $\(String(format: "%.2f", self.amount))", for: .normal)
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
