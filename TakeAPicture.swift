//
//  TakeAPictureWithARedPanda.swift
//  MapProj
//
//  Created by Jordan Kiley on 7/13/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class TakeAPicture : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var currentImage: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hi!")
    }
    
    func postAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        imagePicker.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func takeAPicture(sender: AnyObject) {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .Camera
            imagePicker.cameraCaptureMode = .Photo
            presentViewController(imagePicker, animated: true, completion: {})
        } else {
            postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
        
    }
    //    func getPicture()
    
}


