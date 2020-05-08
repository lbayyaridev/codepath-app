//
//  PostCell.swift
//  Parstagram
//
//  Created by Laith M Bayyari on 2/27/20.
//  Copyright © 2020 laith. All rights reserved.
//

import UIKit
import SendBirdSDK
import Parse

class SinglePostCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc
    func didDoubleTap() {
        if smallLike.imageView != UIImage(named: "oneLike") {
            likeAnimator.animate { [weak self] in
                self?.smallLike.setImage(UIImage(named: "oneLike"), for: .normal)
                let query = PFQuery(className:"Posts")
                query.whereKey("groupid", equalTo: self?.groupID?.channelUrl)
                query.whereKey("challenge", equalTo: self?.challengeName)
                query.whereKey("objectId", equalTo: self!.postID)
                var curr = ""
                do {
                    let objects = try query.findObjects()
                    for object in objects {
                        curr = object["likes"] as! String
                    }
                } catch {
                    print(error)
                }
                var intCurr = Int(curr)
                intCurr! += 1
                curr = "\(intCurr)"
                
                let post = PFObject(className: "Posts")
                
                let newCurr = curr.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
                post["likes"] = newCurr
                
                // Fix Saving Issues

                post.saveInBackground { (success, error) in
                    if success {
                        print("Comment Like")
                    } else {
                        print ("Error Saving Like \(error)")
                    }
                }


                self?.numLikes.text = newCurr
                
                
            }
        }
        
    }

}

