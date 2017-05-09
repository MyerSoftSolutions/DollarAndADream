//
//  DDMapViewController.swift
//  DollarAndADream
//
//  Created by Joel Myers on 5/8/17.
//  Copyright © 2017 Dollar & a Dream LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DDMapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var receiverTypeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("X")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quickSendTapped(_ sender: Any) {
    }


}
