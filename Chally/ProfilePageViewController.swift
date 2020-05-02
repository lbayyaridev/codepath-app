//
//  ProfilePageViewController.swift
//  Chally
//
//  Created by user169342 on 5/1/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class ProfilePageViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileBio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        profileName.text = user?["profileName"] as! String
        profileBio.text = user?["bio"] as! String
        let imageFile = user?["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        profileImage.af_setImage(withURL: url)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        let user = PFUser.current()
        profileName.text = user?["profileName"] as! String
        profileBio.text = user?["bio"] as! String
        let imageFile = user?["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        profileImage.af_setImage(withURL: url)
    }



 
}

