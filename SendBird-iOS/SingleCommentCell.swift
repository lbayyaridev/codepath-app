//
//  CommentCell.swift
//  Parstagram
//
//  Created by Laith M Bayyari on 3/4/20.
//  Copyright © 2020 laith. All rights reserved.
//

import UIKit

class SingleCommentCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
