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

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var posts = [PFObject]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfilePostCell")
        let post = posts[indexPath.row]
        let imageFile = post["image"] as! PFFileObject
        let urlString = imageFile.url
        let url = URL(string: urlString!)
        cell?.imageView?.sd_setImage(with: url, completed: nil)
        return cell!
    }
    
   
    
    @IBOutlet weak var numPosts: UILabel!
    @IBOutlet weak var numGroups: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var profileBio: UILabel!
    @IBOutlet weak var profileName: UILabel!
    var count = 0
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        query.whereKey("author", equalTo: PFUser.current()!)
        query.order(byDescending: "_created_at")
        query.findObjectsInBackground{(posts, error) in
            if posts != nil{
                self.count+=1
                self.posts = posts!
                self.postsTableView.reloadData()
            }
            
            print("COUNT: \(self.count)")
        }
     
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()
        if  user?["profileName"] == nil {
            profileName.text = "Set a new profile name"
        }else{
            profileName.text = user?["profileName"] as? String
        }
        if  user?["bio"] == nil {
            profileBio.text = "Set a new bio"
        }else{
            profileBio.text = user?["bio"] as? String
        }
        
        if user?["image"] != nil {
            let imageFile = user?["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            print("HERE")
            profileImage.sd_setImage(with: url, completed: nil)
        }else{
            
        }
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        query.whereKey("author", equalTo: PFUser.current()!)
        query.order(byDescending: "_created_at")
        query.findObjectsInBackground{(posts, error) in
            if posts != nil{
                self.count+=1
                self.posts = posts!
                self.postsTableView.reloadData()
            }
            
            self.numPosts.text = String(self.count)
        }

        let groups = (user?["groups"])! as! Array<Any>
        print("COUNT HERE: \(count)")
        numGroups.text = String(groups.count)
        
        
  
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        let user = PFUser.current()
        if  user?["profileName"] == nil {
            profileName.text = "Set a new profile name"
        }else{
            profileName.text = user?["profileName"] as? String
        }
        if  user?["bio"] == nil {
            profileBio.text = "Set a new bio"
        }else{
            profileBio.text = user?["bio"] as? String
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


