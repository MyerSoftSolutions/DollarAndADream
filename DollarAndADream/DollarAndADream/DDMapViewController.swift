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
            //			manager.startUpdatingLocation()
//            MBProgressHUD.showAdded(to: self.checkinMapView, animated: true)
            manager.requestLocation()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.latestLocation = locations.last!
//        print(self.latestLocation)
//        MBProgressHUD.hideAllHUDs(for: self.checkinMapView, animated: true)
        
        mapView.setCenter(CLLocationCoordinate2DMake(latestLocation.coordinate.latitude, latestLocation.coordinate.longitude), animated: true)

        let checkinPin = MKPointAnnotation()
//        checkinPin.coordinate = CLLocationCoordinate2DMake(latestLocation.coordinate.latitude, latestLocation.coordinate.longitude)
        checkinPin.coordinate = latestLocation.coordinate
        checkinPin.title = nil
        mapView.addAnnotation(checkinPin)
        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let center = CLLocationCoordinate2D(latitude: self.latestLocation.coordinate.latitude, longitude: self.latestLocation.coordinate.longitude)

        let savedRegion = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(savedRegion, animated: false)
        let camera = MKMapCamera(lookingAtCenter: center, fromEyeCoordinate: center, eyeAltitude: 1610)
        mapView.setCamera(camera, animated: true)

        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let mRect = self.mapView.visibleMapRect
        let eastMapPoint = MKMapPointMake(MKMapRectGetMinX(mRect), MKMapRectGetMidY(mRect))
        let westMapPoint = MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMidY(mRect))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let ann = MKAnnotationView()
        ann.image = UIImage(named: "Map_pin")
        
        return ann
    }
    //MARK: MAPBOX DELEGATE METHOD

//    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
//        // Try to reuse the existing ‘pisa’ annotation image, if it exists.
//        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "pin")
//        
//        if annotationImage == nil {
//            // Leaning Tower of Pisa by Stefan Spieler from the Noun Project.
//            let image = UIImage(named: "CheckinPin")!
//            var newImage : UIImage = self.ResizeImage(image, targetSize: CGSize(width: 69.0, height: 60.0))
//            
//            // The anchor point of an annotation is currently always the center. To
//            // shift the anchor point to the bottom of the annotation, the image
//            // asset includes transparent bottom padding equal to the original image
//            // height.
//            //
//            // To make this padding non-interactive, we create another image object
//            // with a custom alignment rect that excludes the padding.
//            newImage = newImage.withAlignmentRectInsets(UIEdgeInsetsMake(0, 0, newImage.size.height/2, 0))
//            
//            // Initialize the ‘pisa’ annotation image with the UIImage we just loaded.
//            annotationImage = MGLAnnotationImage(image: newImage, reuseIdentifier: "pin")
//        }
//        
//        return annotationImage
//    }
    
    func ResizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }


}
