//
//  PostCell.swift
//  Parstagram
//
//  Created by Laith M Bayyari on 2/27/20.
//  Copyright © 2020 laith. All rights reserved.
//

import UIKit

class SinglePostCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

