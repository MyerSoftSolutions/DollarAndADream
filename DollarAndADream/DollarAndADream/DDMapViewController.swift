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

class CustomPointAnnotation : MKPointAnnotation {
    var pinImageName : String!
}

class DDMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var receiverTypeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    let locationMan = CLLocationManager()
    var latestLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCustomBackButton("X")
        
        locationMan.delegate = self
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationMan.requestAlwaysAuthorization()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func quickSendTapped(_ sender: Any) {
    }

    //MARK: LOCATION MANAGER
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.distanceFilter = kCLDistanceFilterNone
            manager.desiredAccuracy = kCLLocationAccuracyKilometer
       
            manager.requestLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.latestLocation = locations.last!
        
        mapView.setCenter(CLLocationCoordinate2DMake(latestLocation.coordinate.latitude, latestLocation.coordinate.longitude), animated: true)

        let checkinPin = MKPointAnnotation()
//        checkinPin.coordinate = CLLocationCoordinate2DMake(latestLocation.coordinate.latitude, latestLocation.coordinate.longitude)
        checkinPin.coordinate = latestLocation.coordinate
        checkinPin.title = nil
        mapView.addAnnotation(checkinPin)
        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let center = CLLocationCoordinate2D(latitude: self.latestLocation.coordinate.latitude, longitude: self.latestLocation.coordinate.longitude)
        
        let info = CustomPointAnnotation()
        info.coordinate = CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude - CLLocationDegrees(exactly: 0.003)!,self.latestLocation.coordinate.longitude + CLLocationDegrees(exactly: 0.003)!)
        let info2 = CustomPointAnnotation()
        info2.coordinate = CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude - CLLocationDegrees(exactly: 0.002)!,self.latestLocation.coordinate.longitude + CLLocationDegrees(exactly: 0.002)!)
        let info3 = CustomPointAnnotation()
        info3.coordinate = CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude + CLLocationDegrees(exactly: 0.0023)!,self.latestLocation.coordinate.longitude - CLLocationDegrees(exactly: 0.003)!)
        let info4 = CustomPointAnnotation()
        info4.coordinate = CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude + CLLocationDegrees(exactly: 0.002)!,self.latestLocation.coordinate.longitude - CLLocationDegrees(exactly: 0.00175)!)
        let info5 = CustomPointAnnotation()
        info5.coordinate = CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude + CLLocationDegrees(exactly: 0.0012)!,self.latestLocation.coordinate.longitude - CLLocationDegrees(exactly: 0.00245)!)


        mapView.addAnnotation(info)
        mapView.addAnnotation(info2)
        mapView.addAnnotation(info3)
        mapView.addAnnotation(info4)
        mapView.addAnnotation(info5)



        let savedRegion = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(savedRegion, animated: false)
        
        let camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: center, eyeAltitude: 1610)
        mapView.setCamera(camera, animated: true)

        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is CustomPointAnnotation) {
            let reuseId = "Location"
            
            var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if anView == nil {
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView!.canShowCallout = true
            }
            else {
                anView!.annotation = annotation
            }
            let cpa = annotation as! CustomPointAnnotation
            anView!.image = UIImage(named: "star")
            
            return anView
        } else {
            let ann = MKAnnotationView()
            ann.image = UIImage(named: "Map_pin")
            
            return ann
        }
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let mRect = self.mapView.visibleMapRect
        let eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect))
        let westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    }
