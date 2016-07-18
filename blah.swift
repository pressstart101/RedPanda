////
////  File.swift
////  MapProj
////
////  Created by Flatiron School on 7/18/16.
////  Copyright © 2016 Flatiron School. All rights reserved.
////
//
//import Foundation
////
////  ViewController.swift
////  MapProj
////
////  Created by Flatiron School on 7/11/16.
////  Copyright © 2016 Flatiron School. All rights reserved.
////
//
//import UIKit
//import CoreLocation
//import MapKit
//import DKCamera
//
////class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegaate {
//    @IBOutlet weak var map: MKMapView!
//    
//    @IBOutlet weak var photoButton: UIButton!
//    
//    var locationManager = CLLocationManager()
//    var locationChoice : (String, latitude: Double, longitude: Double)!
//    var locationCoordinates = CLLocation()
//    var center = CLLocationCoordinate2D()
//    var circleRegion = CLCircularRegion()
//    
//    
//    override func viewWillAppear(animated: Bool) {
//        
//        super.viewWillAppear(animated) // No need for semicolon
//        
//        photoButton.hidden = true
//        photoButton.enabled = false
//        
//        //Array of Animals to Choose from
//        let animalOptions = ["Red Panda"]
//        pickAnimal(animalOptions)
//        
//        locationChoice = (place : "National Museum of the American Indian", latitude : 40.704001, longitude : -74.013725)
//        locationCoordinates = CLLocation(latitude: locationChoice.1, longitude: locationChoice.2)
//        
//        setupMap()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    func setupLocationManager() {
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization() //Grants access to user location when app is in use
//        self.locationManager.startUpdatingLocation()
//        locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    }
//    
//    func setupMap() {
//        setupLocationManager()
//        
//        
//        map.delegate = self
//        map.showsUserLocation = true
//        map.userTrackingMode = .Follow
//        map.mapType = MKMapType.Standard //.HybridFlyover to change view
//        map.addAnnotation(annotationZ)
//        map.setCamera(mapCamera, animated: true)
//        setupLocationForCircle()
//        
//        
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//        self.map.showsUserLocation = true
//        self.locationManager.startMonitoringForRegion(circleRegion)
//        self.circleRegion.notifyOnEntry = true
//        self.locationManager(locationManager, didEnterRegion: circleRegion)
//        
//        let newYorkLocation = CLLocationCoordinate2DMake(locationCoordinates.coordinate.latitude, -locationCoordinates.coordinate.longitude)
//        // Drop a pin
//        let dropPin = MKPointAnnotation()
//        dropPin.coordinate = newYorkLocation
//        dropPin.title = "New York City"
//        dropPin.subtitle = "address"
//        map.addAnnotation(dropPin)
//        
//        
//        
//        let museumLocation = CLLocationCoordinate2DMake(40.704334, -74.013978)
//        // Drop a pin
//        let dropPin1 = MKPointAnnotation()
//        dropPin1.coordinate = museumLocation
//        dropPin1.title = "National Museum of the American Indian"
//        dropPin1.subtitle = "Red Panda"
//        map.addAnnotation(dropPin1)
//        
//        
//        
//        let woolworthBuildingLocation = CLLocationCoordinate2DMake(40.712449, -74.008292)
//        // Drop a pin
//        let dropPin2 = MKPointAnnotation()
//        dropPin2.coordinate = woolworthBuildingLocation
//        dropPin2.title = "The Woolworth Building"
//        dropPin2.subtitle = "Red Panda"
//        map.addAnnotation(dropPin2)
//        
//        
//        
//        
//        
//        let washingtonSquareParkLocation = CLLocationCoordinate2DMake(40.730823, -73.997332)
//        // Drop a pin
//        let dropPin3 = MKPointAnnotation()
//        dropPin3.coordinate = washingtonSquareParkLocation
//        dropPin3.title = "Washington Square Park"
//        dropPin3.subtitle = "Red Panda"
//        map.addAnnotation(dropPin3)
//        
//        
//        let brooklynBridgeLocation = CLLocationCoordinate2DMake(40.706086, -73.996864)
//        // Drop a pin
//        let dropPin4 = MKPointAnnotation()
//        dropPin4.coordinate = brooklynBridgeLocation
//        dropPin4.title = "Brooklyn Bridge"
//        dropPin4.subtitle = "Red Panda"
//        map.addAnnotation(dropPin4)
//        
//        
//        
//        let flatironBuildingLocation = CLLocationCoordinate2DMake(40.741061, -73.989699)
//        // Drop a pin
//        let dropPin5 = MKPointAnnotation()
//        dropPin5.coordinate = flatironBuildingLocation
//        dropPin5.title = "Flatiron Building"
//        dropPin5.subtitle = "Red Panda"
//        map.addAnnotation(dropPin5)
//        
//        
//        
//        
//        
//        let userCoordinate = CLLocationCoordinate2D(latitude: locationCoordinates.coordinate.latitude, longitude: -locationCoordinates.coordinate.longitude)
//        let eyeCoordinate = CLLocationCoordinate2D(latitude: locationCoordinates.coordinate.latitude, longitude: -locationCoordinates.coordinate.longitude)
//        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 500.0)
//        let annotationZ = MKPointAnnotation()
//        
//
//    }
//    func pickAnimal(selectionOfAnimals : [String]) -> String {
//        let arrayLength : UInt32 = UInt32(selectionOfAnimals.count) // Converts array count to UInt32 so it can be randomized
//        let randomNumber = Int(arc4random_uniform(arrayLength)) //picks random index in random location array
//        let selectedAnimal = selectionOfAnimals[randomNumber]
//        return selectedAnimal
//    }
//    func randomLocation(arrayOfLocations : [( place : String, latitude: CLLocationDegrees, longitude : CLLocationDegrees)]) -> ( place : String, latitude: CLLocationDegrees, longitude : CLLocationDegrees)  {
//        let arrayLength : UInt32 = UInt32(arrayOfLocations.count) // Converts array count to UInt32 so it can be randomized
//        let randomNumber = Int(arc4random_uniform(arrayLength)) //picks random index in random location array
//        let selectedPlace = arrayOfLocations[randomNumber]
//        return selectedPlace
//    }
//    
//    //location manager. should probably change the span for something closer than "1" later
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last
//        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.88))
//        self.map.setRegion(region, animated: true)
//        //        self.locationManager.stopUpdatingLocation()
//    }
//    
//    //to have it throw an error if there is one while load
//    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        print("Errors: " + error.localizedDescription)
//        
//    }
//    
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//        // Dont show a custom image if the annotation is the user's location.
//        guard !annotation.isKindOfClass(MKUserLocation) else {
//            return nil
//        }
//        
//        let annotationIdentifier = "AnnotationIdentifier"
//        
//        var annotationView: MKAnnotationView?
//        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier) {
//            annotationView = dequeuedAnnotationView
//            annotationView?.annotation = annotation
//        }
//        else {
//            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//            av.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
//            annotationView = av
//        }
//        if let annotationView = annotationView {
//            // Configure your annotation view here
//            annotationView.canShowCallout = true
//            annotationView.image = UIImage(named: "redpanda3d.png")
//        }
//        return annotationView
//    }
//    
//    
//    //Map Radius Stuff
//    func setupLocationForCircle() {
//        if CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion.self) {
//            let title = String(locationChoice.0)
//            center = CLLocationCoordinate2D(latitude: locationCoordinates.coordinate.latitude, longitude: locationCoordinates.coordinate.longitude)
//            let regionRadius = 200.0
//            
//            circleRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude), radius: regionRadius, identifier: title)
//            
//            let redPandaAnnotation = MKPointAnnotation()
//            redPandaAnnotation.coordinate = center
//            redPandaAnnotation.title = "\(title)"
//            map.addAnnotation(redPandaAnnotation)
//            
//            let circle = MKCircle(centerCoordinate: center, radius: regionRadius)
//            map.addOverlay(circle)
//        } else {
//            print("Nope")
//        }
//    }
//    
//    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
//        let circleRenderer = MKCircleRenderer(overlay: overlay)
//        circleRenderer.strokeColor = UIColor(red: 0.094, green:0.655, blue:0.710, alpha:1.0)
//        circleRenderer.fillColor = UIColor(red: 0.094, green:0.655, blue:0.710, alpha:0.3)
//        circleRenderer.lineWidth = 0.75
//        return circleRenderer
//        
//    }
//
//
//
//func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    let location = locations.last
//    let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
//    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//    self.map.setRegion(region, animated: true)
//    self.locationManager.stopUpdatingLocation()
//}
//
//    //Not Working - Method to enable photo button when you enter region
//    func locationManagerEnter(manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        photoButton.enabled = true
//        photoButton.hidden = false
//    }
//    
//    @IBAction func photoButton(sender: AnyObject) {
//        let camera = DKCamera()
//        
//        camera.didCancel = { () in
//            print("didCancel")
//            
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
//        
//        camera.didFinishCapturingImage = {(image: UIImage) in
//            print("didFinishCapturingImage")
//            print(image)
//            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
//        self.presentViewController(camera, animated: true, completion: nil)
//    }
//    
////}

