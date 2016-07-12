//
//  ViewController.swift
//  MapProj
//
//  Created by Flatiron School on 7/11/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
@IBOutlet weak var map: MKMapView!
var locationManager = CLLocationManager()
 
    
    
  //copied stuff from viewdidload to viewwill appear to make sure it still shows location after camera access
    override func viewWillAppear(animated: Bool) {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
        super.viewWillAppear(animated) // No need for semicolon
    }
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.map.showsUserLocation = true
        
        
        
    //a random location for testing. need to add an array of them around flatiron
        
        let newYorkLocation = CLLocationCoordinate2DMake(37.7, -122.406417)
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = newYorkLocation
        dropPin.title = "New York City"
        dropPin.subtitle = "address"
        map.addAnnotation(dropPin)
        
        let userCoordinate = CLLocationCoordinate2D(latitude: 37.1927, longitude: 122.0153)
        let eyeCoordinate = CLLocationCoordinate2D(latitude: 37.1927, longitude: 122.0153)
        let mapCamera = MKMapCamera(lookingAtCenterCoordinate: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 400.0)
        let annotationZ = MKPointAnnotation()
        
        
        //Setup the Map View
        map.delegate = self
        map.mapType = MKMapType.Standard //.HybridFlyover to change view
        map.addAnnotation(annotationZ)
        map.setCamera(mapCamera, animated: true)
        
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    //Probably have it in separate file
    @IBOutlet weak var imageTest: UIButton!
    @IBAction func captureImage(){
        let imageFromSource = UIImagePickerController()
        imageFromSource.delegate = self
        imageFromSource.allowsEditing = false
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imageFromSource.sourceType = UIImagePickerControllerSourceType.Camera
        }else{
        
        imageFromSource.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        self.presentViewController(imageFromSource, animated: true, completion: nil)
    }
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
    

    }
    


