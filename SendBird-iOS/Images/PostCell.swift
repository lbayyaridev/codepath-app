//
//  PostCell.swift
//  Chally
//
//  Created by Adib Thaqif on 4/24/20.
//  Copyright © 2020 Adib Thaqif. All rights reserved.
//

import UIKit
import SendBirdSDK
import Parse

class PostCell: UITableViewCell {
    @IBOutlet weak var challengeLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    
    @IBOutlet weak var smallLike: UIButton!
    
    @IBOutlet weak var numLikes: UILabel!
      
    @IBOutlet weak var likeImageViewWidthConstraint: NSLayoutConstraint!
      
    var groupID : SBDGroupChannel? = nil
    
    var challengeName = ""
    
    var postID = ""
    
    
    lazy var likeAnimator = LikeAnimator(container: contentView, layoutConstraint: likeImageViewWidthConstraint)
        
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap))
            tap.numberOfTapsRequired = 2
            photoView.addGestureRecognizer(tap)
        
    }

    @IBAction func tapLike(_ sender: Any) {
        let query = PFQuery(className:"Posts")
        query.whereKey("objectId", equalTo: self.postID)
        var foundUser = false
        var curr = ""
        do {
            let objects = try query.findObjects()
            for object in objects {
                var userLikes = object["userWhoLiked"] as! [String]
                foundUser = userLikes.contains(PFUser.current()!.objectId!)
                print(foundUser)
                if foundUser == true {
                    curr = object["likes"] as! String
                    var intCurr = Int(curr)
                    intCurr! += -1
                    curr = "\(intCurr)"
                    let newCurr = curr.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                    object["likes"] = newCurr
                    var userWhoLiked = object["userWhoLiked"] as! [String]
                    userWhoLiked.removeObject(PFUser.current()!.objectId!)
                    object["userWhoLiked"] = userWhoLiked
                    self.smallLike.setImage(UIImage(named: "emptyLike"), for: .normal)
                    
                }
                else if foundUser == false {
                    curr = object["likes"] as! String
                    var intCurr = Int(curr)
                    intCurr! += 1
                    curr = "\(intCurr)"
                    let newCurr = curr.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                    object["likes"] = newCurr
                    var userWhoLiked = object["userWhoLiked"] as! [String]
                    userWhoLiked.append(PFUser.current()!.objectId!)
                    object["userWhoLiked"] = userWhoLiked
                    self.smallLike.setImage(UIImage(named: "oneLike"), for: .normal)
                }
                object.saveInBackground { (success, error) in
                    if success {
                        print("Like Saved")
                    } else {
                        print ("Error Saving Like \(error)")
                    }
                }
                let newCurr = curr.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                self.numLikes.text = newCurr
                
            }
        } catch {
            print(error)
        }    }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
        @objc
        func didDoubleTap() {
            print("LIT TAP BRO")
            let query = PFQuery(className:"Posts")
            query.whereKey("objectId", equalTo: self.postID)
            var foundUser = false
            do {
                let objects = try query.findObjects()
                for object in objects {
                    var userLikes = object["userWhoLiked"] as! [String]
                    foundUser = userLikes.contains(PFUser.current()!.objectId!)
                    print(foundUser)
                }
            } catch {
                print(error)
            }
        
            if  foundUser == false {
                likeAnimator.animate { [weak self] in
                    self?.smallLike.setImage(UIImage(named: "oneLike"), for: .normal)
                    let query =     PFQuery(className:"Posts")
                    query.whereKey("objectId", equalTo: self!.postID)
                    var curr = ""
                    do {
                        let objects = try query.findObjects()
                        for object in objects {
                            curr = object["likes"] as! String
                            var intCurr = Int(curr)
                            intCurr! += 1
                            curr = "\(intCurr)"
                            let newCurr = curr.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                            object["likes"] = newCurr
                            var userWhoLiked = object["userWhoLiked"] as! [String]
                            userWhoLiked.append((PFUser.current()?.objectId)!)
                            object["userWhoLiked"] = userWhoLiked
                            object.saveInBackground { (success, error) in
                                if success {
                                    print("Like Saved")
                                } else {
                                    print ("Error Saving Like \(error)")
                                }
                            }
                        }
                    } catch {
                        print(error)
                    }
                    
                    
     
                    let newCurr = curr.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                    self?.numLikes.text = newCurr
                    
                    
                }
            }
            
            
            
        }

    }
