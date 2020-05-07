//
//  ItemCell.swift
//  SendBird-iOS
//
//  Created by user169368 on 5/1/20.
//  Copyright © 2020 SendBird. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import SDWebImage

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var challengeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    
    func setData(text: String) {
        self.challengeLabel.text = text
    }
    
    func setImage(pic: PFFileObject) {
        let urlString = pic.url!
        let url = URL(string: urlString)!
        self.imageView.sd_setImage(with: url, completed: nil)
    }
}

