//
//  DDSignUpViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 4/26/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

class DDSignUpViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var accountTypeSegControl: UISegmentedControl!
    @IBOutlet var segBottomToSeparatorCon: NSLayoutConstraint!
    @IBOutlet var recTypeLabelHeightCon: NSLayoutConstraint!
    @IBOutlet var recTypeButtonHeightCon: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("X")
        self.accountTypeSegControl.selectedSegmentIndex = 0
//        self.recTypeLabelHeightCon.constant = 0
//        self.recTypeButtonHeightCon.constant = 0
        self.segBottomToSeparatorCon.constant = 10
        
        self.scrollView.keyboardDismissMode = .interactive
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }

    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.accountTypeSegControl.selectedSegmentIndex = 0
            self.recTypeLabelHeightCon.constant = 0
            self.recTypeButtonHeightCon.constant = 0
            self.segBottomToSeparatorCon.constant = 10
        }  else {
            self.accountTypeSegControl.selectedSegmentIndex = 0
            self.recTypeLabelHeightCon.constant = 22
            self.recTypeButtonHeightCon.constant = 30
            self.segBottomToSeparatorCon.constant = 96
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
