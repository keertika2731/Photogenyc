//
//  UploadImageTabBarVC.swift
//  SocialNetwork
//
//  Created by Keertika on 15/02/18.
//  Copyright © 2018 Keertika Gupta. All rights reserved.
//

import UIKit

class UploadImageTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == tabBar.items![1]
        {
            let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "tab") as!TabBarController
            self.navigationController?.popViewController(animated: true);        }
    }

}
