//
//  SignUpViewController.swift
//  Chally
//
//  Created by user169342 on 4/30/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    @IBOutlet weak var profilenameFeild: UITextField!
    @IBOutlet weak var usernameFeild: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var bioField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
 //   let commentBar = MessageInputBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    /*    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
 */
    
    
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
    
    
    
    @IBAction func onRegister(_ sender: Any) {
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        var user = PFUser()
        user.username = usernameFeild.text
        user.password = passwordField.text
        // other fields can be set just like with PFObject
        user["profileName"] = profilenameFeild.text
        user["bio"] = bioField.text
        user["image"] = file
        
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "registerSegue", sender: nil)
            } else {
                print("Error failed to Register")
            }
        }
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.performSegue(withIdentifier: "backToLoginSegue", sender: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
