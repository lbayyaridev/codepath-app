//
//  FeedViewController.swift
//  Parstagram
//
//  Created by Laith M Bayyari on 2/27/20.
//  Copyright © 2020 laith. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar
import SendBirdSDK
import SDWebImage

class SingleChallengeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    var groupID : SBDGroupChannel? = nil
    
    var challengeName = ""
    
    
    @IBOutlet weak var whatChallenge: UILabel!
    
    @IBOutlet weak var challengePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyBoardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        whatChallenge.text = challengeName
        let query = PFQuery(className:"Posts")
        query.whereKey("groupid", equalTo: groupID!.channelUrl)
        query.whereKey("original", equalTo: true)
        do {
            let objects = try query.findObjects()
            for object in objects {
                let imageFile = object["image"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
                challengePic.sd_setImage(with: url, completed: nil)
            }
        } catch {
            print(error)
        }

        
    }
    
@objc func doubleTapped() {
    // do something here
}
    @objc func keyBoardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
        
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Posts")
        query.whereKey("groupid", equalTo: groupID?.channelUrl as Any)
        query.whereKey("challenge", equalTo: challengeName)
        query.whereKey("original", equalTo: false)
        query.includeKeys(["author", "comments", "comments.author"])
        query.order(byDescending: "_created_at")
        query.limit = 20
        
        query.findObjectsInBackground { (posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // Create the comment
        let comment = PFObject(className: "Comments")
        
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!
        
        selectedPost.add(comment, forKey: "comments")

        selectedPost.saveInBackground { (success, error) in
            if success {
                print("Comment Saved")	
            } else {
                print ("Error Saving Comment \(error)")
            }
        }
        
        tableView.reloadData()
        
        // Clear and dismiss input bar
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        return comments.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SinglePostCell") as! SinglePostCell
            
            
            
            let user = post["author"] as! PFUser
            cell.usernameLabel.text = user.username
            
            cell.captionLabel.text = post["caption"] as? String
            
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            print("WHY NO WORKING")
            print(urlString)
            let url = URL(string: urlString)!
            
            cell.photoView.sd_setImage(with: url, completed: nil)
            
            return cell
            
        } else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleCommentCell") as! SingleCommentCell
            
            let comment = comments[indexPath.row - 1]
            cell.commentLabel.text = comment["text"] as? String
            
            let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
        }
        
    }
    
 
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SinglePostViewController
        {
            let vc = segue.destination as? SinglePostViewController
            vc?.groupID = groupID
            vc?.challengeName = challengeName
        }
    }
    

}
