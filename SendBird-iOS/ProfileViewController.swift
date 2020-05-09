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
import SDWebImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileBio: UILabel!
    @IBOutlet weak var profileName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        if  user?["profileName"] == nil {
            profileName.text = "Set a new profile name"
        }else{
            profileName.text = user?["profileName"] as! String
        }
        if  user?["bio"] == nil {
            profileBio.text = "Set a new bio"
        }else{
            profileBio.text = user?["bio"] as! String
        }
        
        if user?["image"] != nil {
            let imageFile = user?["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            print("HERE")
            profileImage.sd_setImage(with: url, completed: nil)
        }else{
            
        }
        
  
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        let user = PFUser.current()
        if  user?["profileName"] == nil {
            profileName.text = "Set a new profile name"
        }else{
            profileName.text = user?["profileName"] as! String
        }
        if  user?["bio"] == nil {
            profileBio.text = "Set a new bio"
        }else{
            profileBio.text = user?["bio"] as! String
        }
        
        if user?["image"] != nil {
            let imageFile = user?["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            print("HERE")
            profileImage.sd_setImage(with: url, completed: nil)
            
        }
    }
    
}


