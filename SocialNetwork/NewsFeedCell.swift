//
//  NewsFeedCell.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 31/03/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
import Firebase


class NewsFeedCell: UICollectionViewCell {
    var liked = false
    @IBOutlet var shadowView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet var likeLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!

    @IBOutlet var likeButton: UIButton!
    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var caption: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var date: UILabel!
    var postID :String!

    @IBOutlet var likes: UILabel!
    
//
//    - (void)setFrame:(CGRect)frame {
//    frame.origin.x += inset;
//    frame.size.width -= 2 * inset;
//    [super setFrame:frame];
//    }
//
    override func awakeFromNib() {
    
    }
    @IBAction func likeAction(_ sender: Any)
    {
        let ref = Database.database().reference()
        let keyToPost = ref.child("posts").childByAutoId().key
        ref.child("posts").child(self.postID).observeSingleEvent(of: .value, with: {(snapshot) in
            if self.likeButton.image(for: .normal) == UIImage(named:"unlike")
          {
            if let post = snapshot.value as? [String:AnyObject]{
            let updateLikes:[String:Any] = ["peopleWhoLike/\(keyToPost)" : Auth.auth().currentUser!.uid]//auth().curretUser!.id]
            ref.child("posts").child(self.postID).updateChildValues(updateLikes, withCompletionBlock:{(error,ref1) in
                
                
                if error == nil
                {
                    ref.child("posts").child(self.postID).observeSingleEvent(of: .value, with: {(snap) in
                        
                        if let properties = snap.value as? [String:AnyObject]
                        {
                            if let likes = properties["peopleWhoLike"] as? [String:AnyObject]
                            {
                                let count = likes.count
                                self.likeLabel.text = "\(count) Likes "
                              self.liked = true
                                self.likeButton.setImage(UIImage(named:"like"), for: .normal)
                                
                                let update = ["likes":count]
                                  ref.child("posts").child(self.postID).updateChildValues(update)
                            }
                        }
                   })
                }
                
                
            })
            
            }
        }
        else
            {
                if let properties = snapshot.value as? [String:AnyObject]
                {
                    if let peopleWhoLike = properties["peopleWhoLike"] as? [String:AnyObject]
                    {
                        for (id,person) in peopleWhoLike
                        {
                            if person as? String == Auth.auth().currentUser!.uid
                            {
                                ref.child("posts").child(self.postID).child("peopleWhoLike").child(id).removeValue(completionBlock: { (error, reff) in
                                    if error == nil{
                                        ref.child("posts").child(self.postID).observeSingleEvent(of: .value, with: { (snap) in
                                            if let prop = snap.value as? [String:AnyObject]
                                            {
                                                if let likes = prop["peopleWhoLike"] as? [String:AnyObject]
                                                {
                                                    let count = likes.count
                                                    self.likeLabel.text = "\(count) Likes"
                                                    ref.child("posts").child(self.postID).updateChildValues(["likes": count])
                                                    
                                                }
                                               else
                                                {
                                                    self.likeLabel.text = "0 Likes"
                                                    ref.child("posts").child(self.postID).updateChildValues(["likes":0])
                                                }
                                                
                                                self.liked = false
                                                self.likeButton.setImage(UIImage(named:"unlike"), for: .normal)
                                            }
                                    })
                                    }
                                })
                            }
                        }
                        
                    }
                }
            }
            
        })
    ref.removeAllObservers()
    }
}
