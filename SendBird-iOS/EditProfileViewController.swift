//
//  EditProfileViewController.swift
//  SendBird-iOS
//
//  Created by Adib Thaqif on 5/7/20.
//  Copyright © 2020 SendBird. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class EditProfileViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var profileNamefield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Load the the current user data
        let user = PFUser.current()
        usernameField.placeholder = user?.username!
        profileNamefield.placeholder = user?["profileName"] as? String
        passwordField.placeholder = "Enter new password"
        bioField.placeholder = user?["bio"] as? String
        if user?["image"] != nil{
            let imageFile = user?["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            imageView.af_setImage(withURL: url)
        }
        
        
                // Tap to exit keyboard
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Tap to exit Keyboard
        
        // Move screen with Keyboard
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Move screen with Keyboard
        
        // Do any additional setup after loading the view.
    }
    
     // Move screen with Keyboard
       @objc func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               if self.view.frame.origin.y == 0 {
                   self.view.frame.origin.y -= keyboardSize.height
               }
           }
       }

       @objc func keyboardWillHide(notification: NSNotification) {
           if self.view.frame.origin.y != 0 {
               self.view.frame.origin.y = 0
           }
       }
       // Move screen with Keyboard
       
       // Tap to exit Keyboard
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }
       // Tap to exit Keyboard
       
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }else{
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
        
        if let currentUser = PFUser.current(){
            currentUser.username = usernameField.text
            currentUser.password = passwordField.text
            currentUser["bio"] = bioField.text
            currentUser["profileName"] = profileNamefield.text
            currentUser["image"] = file
           
            currentUser.saveInBackground { (success, error) in
                if success {
                    print("successfly updated new profile!")
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("error updating profile!")
                }
            }
        }
    }
}
