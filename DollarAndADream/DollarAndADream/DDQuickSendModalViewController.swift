//
//  DDQuickSendModalViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 5/23/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit
import QuartzCore

class DDQuickSendModalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var quickSendView : UIView?
    var ddSendViewController : DDSendViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overCurrentContext
        view.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DDQuickSendModalViewController.dismissModal))
        tap.delegate = self
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        ddSendViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DDSendViewController") as? DDSendViewController
        view.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT)
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissQuickSendTapNotification"), object: nil)
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissModal() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DismissQuickSendTapNotification"), object: nil)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        quickSendView = ddSendViewController?.view
        
        if (DeviceType.IS_IPHONE_5){
            quickSendView?.frame = CGRect(x: 30.0, y: 80.0, width: ScreenSize.SCREEN_WIDTH - 16.0, height: 450)
        } else if (DeviceType.IS_IPHONE_6){
            quickSendView?.frame = CGRect(x: 46.0, y: 135.0, width: ScreenSize.SCREEN_WIDTH - 24.0, height: 503)
        } else if (DeviceType.IS_IPHONE_6P){
            quickSendView?.frame = CGRect(x: 46.0, y: 135.0, width: ScreenSize.SCREEN_WIDTH - 24.0, height: 503)
        }else {
            quickSendView?.frame = CGRect(x: 46.0, y: 15.0, width: ScreenSize.SCREEN_WIDTH - 24.0, height: 503)
        }
        
        //		abandonedCartView?.frame = CGRectMake(46.0, 135.0, UIScreen.mainScreen().bounds.size.width - 92.0, 503)
        quickSendView?.layer.cornerRadius = 2.5
        quickSendView?.center = view.center
        
        self.view.addSubview(quickSendView!)
        self.addChildViewController(ddSendViewController!)
        ddSendViewController?.didMove(toParentViewController: self)
        
    }

}
