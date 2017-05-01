//
//  DDHomeViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 4/26/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDHomeViewController: UIViewController {

    @IBOutlet var receivedLabelTrailCon: NSLayoutConstraint!
    @IBOutlet var favesLabelTrailCon: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendTapped(_ sender: Any) {
    }

    @IBAction func receivedTapped(_ sender: Any) {
    }
    
    @IBAction func mapTapped(_ sender: Any) {
    }
    
    @IBAction func favoritesTapped(_ sender: Any) {
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
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
