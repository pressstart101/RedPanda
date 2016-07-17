//
//  ViewController.swift
//  MapProj
//
//  Created by Flatiron School on 7/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//


// To Do As of 7/16
// Why is red panda in the middle of the ocean??? Can red pandas swim? I think it's related to this error "Errors: The operation couldn’t be completed. (kCLErrorDomain error 0.)", but IDK what method it's on
// Geofence - Disable/hide button until close to location
// separate pin for current location and
// Add sloths & unicorns?
// Move some features to ViewWillAppear?
// Center map on user's location
// For camera features to work, use on actual iDevice

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    var locationChoice : (String, latitude: Double, longitude: Double)!
    var locationCoordinates = CLLocation()
    let regionRadius : CLLocationDistance = 500
    //copied stuff from viewdidload to viewwill appear to make sure it still shows location after camera access
    override func viewWillAppear(animated: Bool) {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
        super.viewWillAppear(animated) // No need for semicolon
        
        //Array of Animals to Choose from
        let animalOptions = ["Red Panda"]
        pickAnimal(animalOptions)
        
        //Array of locations near/including Flatiron School
        let locationOptions = [(place : "Flatiron School", latitude : 40.705280, longitude : -74.014025), (place : "National Museum of the American Indian", latitude : 40.703708, longitude : -74.014120), ( place : "Woolworth Building", latitude: 40.712085, longitude : -74.008262)]
        locationChoice = randomLocation(locationOptions)
        locationCoordinates = CLLocation(latitude: locationChoice.1, longitude: locationChoice.2)
        print(locationCoordinates)
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization() //Grants access to user location when app is in use
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
        
        
        let newYorkLocation = CLLocationCoordinate2DMake(locationCoordinates.coordinate.latitude, locationCoordinates.coordinate.longitude)
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = newYorkLocation
        dropPin.title = "New York City"
        dropPin.subtitle = "address"
        map.addAnnotation(dropPin)
        
        let userCoordinate = CLLocationCoordinate2D(latitude: locationCoordinates.coordinate.latitude, longitude: locationCoordinates.coordinate.longitude)
        let eyeCoordinate = CLLocationCoordinate2D(latitude: locationCoordinates.coordinate.latitude, longitude: locationCoordinates.coordinate.longitude)
        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 400.0)
        let annotationZ = MKPointAnnotation()
        
        
        
        
        //Setup the Map View
        map.delegate = self
        map.mapType = MKMapType.Standard //.HybridFlyover to change view
        map.addAnnotation(annotationZ)
        map.setCamera(mapCamera, animated: true)
        centerMapOnLocation(locationCoordinates)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickAnimal(selectionOfAnimals : [String]) -> String {
        let arrayLength : UInt32 = UInt32(selectionOfAnimals.count) // Converts array count to UInt32 so it can be randomized
        let randomNumber = Int(arc4random_uniform(arrayLength)) //picks random index in random location array
        let selectedAnimal = selectionOfAnimals[randomNumber]
        return selectedAnimal
    }
    func randomLocation(arrayOfLocations : [( place : String, latitude: CLLocationDegrees, longitude : CLLocationDegrees)]) -> ( place : String, latitude: CLLocationDegrees, longitude : CLLocationDegrees)  {
        let arrayLength : UInt32 = UInt32(arrayOfLocations.count) // Converts array count to UInt32 so it can be randomized
        let randomNumber = Int(arc4random_uniform(arrayLength)) //picks random index in random location array
        let selectedPlace = arrayOfLocations[randomNumber]
        return selectedPlace
    }
    
    
    
    //location manager. should probably change the span for something closer than "1" later
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.88))
        self.map.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    
    
    
    
    //to have it throw an error if there is one while load
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
        
    }
    
    /////////// camera button. has access to photo library. need to add access to camera and make it go straight to it when button tapped.
    
    //enable Camera Button When within certain distance of red panda
    // Send to Camera
    
    
    //Probably have it in separate file
    @IBOutlet weak var imageTest: UIButton!
    //    @IBAction func captureImage(){
    //        let imageFromSource = UIImagePickerController()
    //        imageFromSource.delegate = self
    //        imageFromSource.allowsEditing = false
    //        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
    //            imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
    //        }else{
    //
    //        imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    //        }
    //        self.presentViewController(imageFromSource, animated: true, completion: nil)
    //    }
    ////////////
    
    
    
    
    //this function is to change standard red pin to a custom image
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // Dont show a custom image if the annotation is the user's location.
        guard !annotation.isKindOfClass(MKUserLocation) else {
            return nil
        }
        
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            av.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "redpanda3d.png")
        }
        
        return annotationView
    }
    
    // Centers on location given coordinates
    func centerMapOnLocation(location : CLLocation) {
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius )
        map.setRegion(region, animated : true)
    }
}



