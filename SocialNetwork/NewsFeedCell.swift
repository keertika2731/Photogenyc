//
//  NewsFeedCell.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 31/03/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit

class NewsFeedCell: UICollectionViewCell {

   
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var imageLabel: UIImageView!

    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet weak var likeLabel: UIButton!

    @IBOutlet weak var numberOfLikesLabel: UILabel!


    @IBAction func likeButton(_ sender: Any) {
    }
    
    
}
