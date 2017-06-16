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

class DDAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var name: String!
    var hometown: String!
    var recType: String!
    var descr: String!
    var image: UIImage!

    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

class AnnotationView: MKAnnotationView
{
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil)
        {
            self.superview?.bringSubview(toFront: self)
        }
        return hitView
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.bounds;
        var isInside: Bool = rect.contains(point);
        if(!isInside)
        {
            for view in self.subviews
            {
                isInside = view.frame.contains(point);
                if isInside
                {
                    break;
                }
            }
        }
        return isInside;
    }
}
class DDMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var receiverTypeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    
    let names = ["James Early", "Greg Ang", "Jess T", "MannyM"]
    let towns = ["Riverdale, Ga", "Washington, D.C.", "Atlantic City, NJ", "Nome, VA"]
    let recTypes = ["Entrepreneur", "Education", "Education", "Person in Need"]
    let descs = ["Building a dream that will push the culture", "Education is my most important priority. Thanks in advance", "Working to Graduate and transform my industry!", "I Need your help to build back my ability to provide"]

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
        
        if let quickSendView = UIApplication.shared.keyWindow!.viewWithTag(1000) {
            quickSendView.removeFromSuperview()
            NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "DismissQuickSendNotification"), object: nil)
            NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "DismissQuickSendTapNotification"), object: nil)
            
        }
        let quickSendViewModal = DDQuickSendModalViewController()
        NotificationCenter.default.addObserver(self, selector: #selector(DDMapViewController.dismissQuickSendViewModal), name:NSNotification.Name(rawValue: "DismissQuickSendNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DDMapViewController.dismissQuickSendViewTapModal), name:NSNotification.Name(rawValue: "DismissQuickSendTapNotification"), object: nil)
        
        quickSendViewModal.view.tag = 1000
        UIApplication.shared.keyWindow!.addSubview(quickSendViewModal.view)
        self.addChildViewController(quickSendViewModal)
        quickSendViewModal.didMove(toParentViewController: self)

    }
    
    func dismissQuickSendViewModal() {
        if let quickSendViewModal = UIApplication.shared.keyWindow!.viewWithTag(1000)  {
            quickSendViewModal.removeFromSuperview()
            NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "DismissQuickSendNotification"), object: nil)
              NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "DismissQuickSendTapNotification"), object: nil)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DDMapViewController") as! DDMapViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func dismissQuickSendViewTapModal(){
        if let quickSendViewModal = UIApplication.shared.keyWindow!.viewWithTag(1000)  {
            quickSendViewModal.removeFromSuperview()
            NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "DismissQuickSendNotification"), object: nil)
            NotificationCenter.default.removeObserver(self, name:NSNotification.Name(rawValue: "DismissQuickSendTapNotification"), object: nil)
            
        }
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
        checkinPin.coordinate = latestLocation.coordinate
        checkinPin.title = nil
        mapView.addAnnotation(checkinPin)
        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let center = CLLocationCoordinate2D(latitude: self.latestLocation.coordinate.latitude, longitude: self.latestLocation.coordinate.longitude)
        
        
        let point = DDAnnotation(coordinate: CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude - CLLocationDegrees(exactly: 0.003)!,self.latestLocation.coordinate.longitude + CLLocationDegrees(exactly: 0.003)!))
        point.name = names[0]
        point.hometown = towns[0]
        point.recType = recTypes[0]
        point.descr = descs[0]
        mapView.addAnnotation(point)

        let point2 = DDAnnotation(coordinate: CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude - CLLocationDegrees(exactly: 0.002)!,self.latestLocation.coordinate.longitude + CLLocationDegrees(exactly: 0.002)!))
        point2.name = names[1]
        point2.hometown = towns[1]
        point2.recType = recTypes[1]
        point2.descr = descs[1]
        mapView.addAnnotation(point2)
        
        let point3 = DDAnnotation(coordinate: CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude + CLLocationDegrees(exactly: 0.0023)!,self.latestLocation.coordinate.longitude - CLLocationDegrees(exactly: 0.003)!))
        point3.name = names[2]
        point3.hometown = towns[2]
        point3.recType = recTypes[2]
        point3.descr = descs[2]
        mapView.addAnnotation(point3)


        let point4 = DDAnnotation(coordinate: CLLocationCoordinate2DMake(self.latestLocation.coordinate.latitude + CLLocationDegrees(exactly: 0.002)!,self.latestLocation.coordinate.longitude - CLLocationDegrees(exactly: 0.00175)!))
        point4.name = names[3]
        point4.hometown = towns[3]
        point4.recType = recTypes[3]
        point4.descr = descs[3]
        mapView.addAnnotation(point4)

        let savedRegion = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(savedRegion, animated: false)
        
        let camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: center, eyeAltitude: 1610)
        mapView.setCamera(camera, animated: true)

        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation is DDAnnotation) {
            let reuseId = "Location"
            
            var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            if anView == nil {
                anView = AnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                anView?.canShowCallout = false
            }
            else {
                anView!.annotation = annotation
                anView?.canShowCallout = false

            }
            anView!.image = UIImage(named: "star")
            
            return anView
        } else {
            let ann = MKAnnotationView()
            ann.image = UIImage(named: "Map_pin")
            
            return ann
        }
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // 1
        if view.annotation is MKUserLocation
        {
            // Don't proceed with custom callout
            return
        }
        // 2
        let annotation = view.annotation as! DDAnnotation
        
        self.nameLabel.text = annotation.name
        self.locationLabel.text = annotation.hometown
        self.receiverTypeLabel.text = annotation.recType
        self.descriptionLabel.text = annotation.descr
        
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
