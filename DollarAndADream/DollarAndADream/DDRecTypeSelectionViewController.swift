//
//  DDRecTypeSelectionViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 6/16/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit



protocol DDRecTypePickerDelegate {
    func typeSelected(_ rowPressed: Int)
}

class DDRecTypeSelectionViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    var forGraphVal : Int?
    
    var arr = ["Education", "Person in Need", "Entrepreneur", "Non-Profit"]
    var delegate : DDRecTypePickerDelegate?
    var selectedIdx : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.selectRow(selectedIdx!, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.typeSelected(row)
        
    }
    
}

protocol RecTypeSelectionModalDelegate {
    func selectMetric(_ idx: Int)
    func nixModal()
}

class RecTypeSelectionModalController : UIViewController, DDRecTypePickerDelegate, UIGestureRecognizerDelegate{
    
    var pickerView : UIView?
    var pickerViewController : DDRecTypeSelectionViewController?
    var modalDelegate : RecTypeSelectionModalDelegate?
    var forGraphVal : Int?
    var selectedIdx : Int?
    var arr : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overCurrentContext
        self.view.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RecTypeSelectionModalController.dismissModal))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        pickerViewController = DDRecTypeSelectionViewController(nibName: "DDRecTypeSelectionViewController", bundle: nil)
        if arr != nil {
            pickerViewController?.arr = self.arr!
        }
        pickerViewController?.forGraphVal = self.forGraphVal
        pickerViewController?.selectedIdx = selectedIdx
        pickerViewController?.delegate = self
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        
    }
    
    func typeSelected(_ rowPressed: Int) {
        modalDelegate?.selectMetric(rowPressed)
    }

    
    @objc func dismissModal() {
        self.modalDelegate?.nixModal()
    }
    //
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        pickerView = pickerViewController?.view
        //        metricPickerView?.layer.cornerRadius = 7.0
        
        
        pickerView?.frame = CGRect(x: 17.0, y: 40.0, width: UIScreen.main.bounds.size.width, height: 215)
        
        pickerView!.center = self.view.center
        
        self.view.addSubview(pickerView!)
        self.addChildViewController(pickerViewController!)
        pickerViewController?.didMove(toParentViewController: self)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

