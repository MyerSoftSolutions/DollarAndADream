//
//  DDSignUpViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 4/26/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit

protocol SignInViewDelegate {
    func signInComplete()
}

class DDSignUpViewController: UIViewController, UIScrollViewDelegate, RecTypeSelectionModalDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var accountTypeSegControl: UISegmentedControl!
    @IBOutlet var segBottomToSeparatorCon: NSLayoutConstraint!
    @IBOutlet var recTypeLabelHeightCon: NSLayoutConstraint!
    @IBOutlet var recTypeButtonHeightCon: NSLayoutConstraint!
    @IBOutlet weak var recTypeView: UIView!
    @IBOutlet weak var recTypeBtn: UIButton!
    var arr = ["EDUCATION", "PERSON IN NEED", "ENTREPRENEUR", "NON-PROFIT"]
    var index = 0
    var delegate : SignInViewDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("X")
        self.createCustomSubmitButton("Submit")
        self.accountTypeSegControl.selectedSegmentIndex = 0
        self.segBottomToSeparatorCon.constant = 10
        
        self.scrollView.keyboardDismissMode = .interactive
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }

    override func submitButtonClicked() {
        delegate?.signInComplete()
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            recTypeView.isHidden = true
            self.accountTypeSegControl.selectedSegmentIndex = 0
            self.segBottomToSeparatorCon.constant = 10
        }  else {
            recTypeView.isHidden = false
            self.accountTypeSegControl.selectedSegmentIndex = 1
            self.segBottomToSeparatorCon.constant = 88
        }
        
        
    }
    @IBAction func recTypePressed(_ sender: UIButton) {
        
        if let pickerModalView = UIApplication.shared.keyWindow!.viewWithTag(2000) {
            pickerModalView.removeFromSuperview()
        }
        
        let pickerModal = RecTypeSelectionModalController()
        pickerModal.arr = ["Education", "Person in Need", "Entrepreneur", "Non-Profit"]
        
        pickerModal.modalDelegate = self
        pickerModal.selectedIdx = index
        
        pickerModal.view.tag = 2000
        
        UIApplication.shared.keyWindow!.addSubview(pickerModal.view)
        self.addChildViewController(pickerModal)
        pickerModal.didMove(toParentViewController: self)
    }
    
    
    //MARK: RecTypePickerModalDelegate Methods
    func selectMetric(_ idx: Int) {
        recTypeBtn.setTitle(arr[idx], for: .normal)
        index = idx
        if let invalidView = UIApplication.shared.keyWindow!.viewWithTag(2000) {
            invalidView.removeFromSuperview()
        }

    }
    
    func nixModal() {
        if let invalidView = UIApplication.shared.keyWindow!.viewWithTag(2000) {
            invalidView.removeFromSuperview()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
