//
//  LaunchVC.swift
//  SocialNetwork
//
//  Created by Keertika on 07/02/18.
//  Copyright © 2018 Keertika Gupta. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstVC")
        self.navigationController?.pushViewController(destinationVC!, animated: false)
       
    }



}
