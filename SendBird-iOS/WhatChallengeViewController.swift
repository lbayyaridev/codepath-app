//
//  WhatChallengeViewController.swift
//  SendBird-iOS
//
//  Created by user169368 on 5/8/20.
//  Copyright © 2020 SendBird. All rights reserved.
//

import UIKit
import Parse
import SendBirdSDK
import SDWebImage

class WhatChallengeViewController: UIViewController {
    
    @IBOutlet weak var challengeField: UILabel!
    @IBOutlet weak var originalPic: UIImageView!
    
    var groupID : SBDGroupChannel? = nil
    var challengeName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        challengeField.text = challengeName
        let query = PFQuery(className:"Posts")
        query.whereKey("groupid", equalTo: groupID!.channelUrl)
        query.whereKey("challenge", equalTo: challengeName)
        query.whereKey("original", equalTo: true)
        do {
            let objects = try query.findObjects()
            for object in objects {
                let imageFile = object["image"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                originalPic.sd_setImage(with: url, completed: nil)
            }
        } catch {
            print(error)
        }
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
