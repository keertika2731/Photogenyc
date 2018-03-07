//
//  UsersNibCellTableViewCell.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 03/03/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
import Firebase
protocol followButtonDelegate:class
{
    func followButtonTapped(at index: Int)//3
   // func abc()
}
class UsersNibCellTableViewCell: UITableViewCell
{
  
    var id:Int!
    weak var delegate:followButtonDelegate!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var label: UILabel!
   
    var indexPath:IndexPath!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func followButtonAction(_ sender: Any)
    {
        print("followButtonAction")
      
      //  var obj = UsersVC()
       // obj.followButtonTapped(at: indexPath)
       self.delegate?.followButtonTapped(at: id)//4
      
    }
    

}
