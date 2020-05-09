//
//  FeedViewController.swift
//  Chally
//
//  Created by Adib Thaqif on 4/24/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar
import SDWebImage
import QuartzCore


@available(iOS 13.0, *)
class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MessageInputBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    var posts = [PFObject]()
    var selectedPost: PFObject!
    let commentBar = MessageInputBar()
    var showsCommentBar = false

    override func viewDidLoad() {
        super.viewDidLoad()
               
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
               
        commentBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
               
        tableView.keyboardDismissMode = .interactive
               
        let center = NotificationCenter.default
            center.addObserver(self, selector: #selector(keyboardWillbeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillbeHidden(note: Notification){
           commentBar.inputTextView.text = nil
           showsCommentBar = false
           becomeFirstResponder()
           
       }
    
    override var inputAccessoryView: UIView?{
           return commentBar
    }
    
       
    override var canBecomeFirstResponder: Bool{
           return showsCommentBar
    }
    //TODO: get only your posts, global posts, and posts for groups that you are in
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query = PFQuery(className: "Posts")
        query.whereKey("original", equalTo: false)
        query.includeKeys(["author","comments","comments.author"])
        query.limit = 20
        query.whereKey("original", equalTo: false)
        query.findObjectsInBackground{
            (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        return comments.count + 2
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.section]
        let comments = (post["comment"] as? [PFObject]) ?? []
        
        if indexPath.row == comments.count + 1{
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
            
            selectedPost = post
            
        }
    }

       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            let user = post["author"] as! PFUser
            //print("USERNAME")
            print(user.username!)
            cell.usernameLabel.text = user.username
            cell.captionLabel.text = post["caption"] as? String
            cell.challengeLabel.text = post["challenge"] as? String
            print(cell.captionLabel.text!)
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            print(urlString)
            cell.photoView.sd_setImage(with: url, completed: nil)
            
                        
            cell.photoView.layer.cornerRadius = 10;
            cell.photoView.clipsToBounds = true
            cell.numLikes.text = post["likes"] as! String
            cell.postID = (post.objectId ?? "")
            
            var userWhoLiked = post["userWhoLiked"] as! [String]
            if userWhoLiked.contains((PFUser.current()?.objectId)!) {
                cell.smallLike.setImage(UIImage(named: "oneLike"), for: .normal)
                
            }
            
            return cell
        }else if indexPath.row <= comments.count{
            print("HERE")
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            let comment = comments[indexPath.row - 1]
            cell.commentLabel.text = comment["text"] as? String
            //cell.commentLabel.text = ""
            let user = comment["author"] as! PFUser
            cell.usernameLabel.text = user.username
          return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell
        }
        
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
        ConnectionManager.logout{}
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
               let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
               sceneDelegate.window?.rootViewController = loginViewController
 
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
          // Create the comment
          let comments = PFObject(className: "Comments")
          comments["text"] = text
          comments["author"] = PFUser.current()!
          comments["post"] = selectedPost

          selectedPost.add(comments, forKey: "comments")

          selectedPost.saveInBackground{ (success,error) in
              if success {
                  print("success saving comment")
              }else{
                  print("error saving comment")
              }
          }
          tableView.reloadData()
          // Clear and dismiss input bar
          commentBar.inputTextView.text = nil
          showsCommentBar = false
          becomeFirstResponder()
          commentBar.inputTextView.resignFirstResponder()
          
      }
       
}
