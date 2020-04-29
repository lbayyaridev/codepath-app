//
//  ProfileViewController.swift
//  Chally
//
//  Created by user169342 on 4/24/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 170, height: 170)
        let scaledImage = image.af_imageScaled(to: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onSaveButton(_ sender: Any) {
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        let query = PFQuery(className:"Profile")
        query.getObjectInBackground(withId: "9nBJK1WEQZ") { (profile: PFObject?, error: Error?) in
            if let error = error {
                        let profile = PFObject(className: "Profile")
                
                profile["owner"] = PFUser.current()!
                profile["name"] = self.profileNameField.text
                profile["bio"] = self.bioField.text
                profile["image"] = file
                
                profile.saveInBackground { (success, error) in
                    if success {
                        print("success made new profile!")
                    } else {
                        print("error updating profile!")
                    }
                }
                
                
                
            } else if let profile = profile {
                profile["name"] = self.profileNameField.text
                profile["bio"] = self.bioField.text
                profile["image"] = file
                profile.saveInBackground { (success, error) in
                    if success {
                        print("success made new profile!")
                    } else {
                        print("error updating profile!")
                    }
                }
                
            }
        }

    }
    

}
