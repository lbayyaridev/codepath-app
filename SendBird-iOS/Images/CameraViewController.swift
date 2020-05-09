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
import PhotoEditorSDK

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var challengeLabel: UILabel!
    var challenge = ""
    @IBOutlet weak var commentField: UITextField!
    
    @IBAction func onCameraButton(_ sender: Any) {
        /* let picker = UIImagePickerController()
         picker.delegate = self
         picker.allowsEditing = true
         if UIImagePickerController.isSourceTypeAvailable(.camera){
         picker.sourceType = .camera
         }else{
         picker.sourceType = .photoLibrary
         }
         present(picker, animated: true, completion: nil) */
        let cameraViewController = CameraViewController()
        cameraViewController.dataCompletionBlock = { [unowned cameraViewController] data in
            guard let data = data else {
                return
            }
            
            let photo = Photo(data: data)
            let photoEditViewController = PhotoEditViewController(photoAsset: photo)
            photoEditViewController.delegate = self
            
            cameraViewController.present(photoEditViewController, animated: true, completion: nil)
        }
        
        cameraViewController.completionBlock = { [unowned cameraViewController] image, _ in
            guard let image = image else {
                return
            }
            
            let photo = Photo(image: image)
            let photoEditViewController = PhotoEditViewController(photoAsset: photo)
            photoEditViewController.delegate = self
            
            cameraViewController.present(photoEditViewController, animated: true, completion: nil)
        }
        
        present(cameraViewController, animated: true, completion: nil)
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
        post["challenge"] = challenge
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        post["image"] = file
        post["local"] = false
        post["groupid"] = "no groupid"
        post.saveInBackground{ (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                
            }else{
                print(error?.localizedDescription)
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CHALLENGE: \(challenge)")
        challengeLabel.text = challenge
        
        // Do any additional setup after loading the view.
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
