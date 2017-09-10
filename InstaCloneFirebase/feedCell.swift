//
//  feedCell.swift
//  InstaCloneFirebase
//
//  Created by Samet ÇELİKBIÇAK on 10.09.2017.
//  Copyright © 2017 Samet ÇELİKBIÇAK. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postText: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
