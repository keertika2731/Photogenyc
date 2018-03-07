//
//  ProfileVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 21/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBAction func uploadImageButton(_ sender: Any)
    {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

@IBAction func ProfileButton(_ sender: Any)
{                                let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadPicturesVC") as! UploadPicturesVC
show(destinationVC, sender: nil)
    
    }
}
