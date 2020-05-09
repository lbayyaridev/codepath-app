//
//  CameraViewController.swift
//  Chally
//
//  Created by Adib Thaqif on 4/23/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import SendBirdSDK

class SinglePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    

    
    @IBOutlet weak var commentField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var challengeField: UILabel!
    
    var groupID : SBDGroupChannel? = nil
    var challengeName = ""
    
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
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to:size)
        imageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
    
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["image"] = file
        
        post["groupid"] = groupID?.channelUrl
        post["challenge"] = challengeName
        post["original"] = false
        post["local"] = true
        post["likes"] = "0"
        post["userWhoLiked"] = [String]()
        
        // Need to create a error if trying to add existing challenge
        
        post.saveInBackground{ (success,error) in
            if success {
                print("success posting")
                self.dismiss(animated: true) {
                    
                }
            }else{
                print("error posting")
            }
        }
        
        
        
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        challengeField.text = challengeName
        

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        
    }
    

}

