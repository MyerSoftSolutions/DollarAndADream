//
//  DDLoginViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 4/26/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDLoginViewController: UIViewController {

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SignUpSegue" {
//
//            let navi = segue.destination as! UINavigationController
//            let vc = navi.viewControllers[0] as! DDSignUpViewController
//
//        }
//    }
    @IBAction func signUpTapped(_ sender: UIButton) {
        //Segue to SignUpViewController
        
    }

}
