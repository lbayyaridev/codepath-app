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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground{(posts, error) in
            if posts != nil {
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
        //print("indexPath.row = \(indexPath.row)")
        //print("comments.count = \(comments.count)")
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            let user = post["author"] as! PFUser
            
            print(user.username)
            cell.usernameLabel.text = user.username
            cell.captionLabel.text = post["caption"] as? String
            cell.challengeLabel.text = post["challenge"] as? String
            print(cell.captionLabel.text)
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
            print(urlString)
            cell.photoView.sd_setImage(with: url, completed: nil)
            return cell
        }else if indexPath.row <= comments.count{
            print("HERE")
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            let comment = comments[indexPath.row - 1]
            print("AUTHOR: \(comment["author"])")
            cell.commentLabel.text = comment["text"] as? String
            //cell.commentLabel.text = ""
            let user = comment["author"] as! PFUser
            cell.usernameLabel.text = user.username
            print("USERNAME:\(user.username)")
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell
        }
        
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        /* PFUser.logOut()
               
               let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
               let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
               sceneDelegate.window?.rootViewController = loginViewController
 */
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