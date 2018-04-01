//
//  TabBarController.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 04/04/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
            let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "NewsFeedVC")
        let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "UploadPicturesVC")
        let vc3 = self.storyboard?.instantiateViewController(withIdentifier: "UsersVC")
let viewControllers = [vc1,vc2,vc3]
        self.viewControllers = viewControllers as! [UIViewController]
      tabBarController?.tabBar.items![0].badgeValue = "Home"
        tabBarController?.tabBar.items![1].badgeValue = "Post"
        tabBarController?.tabBar.items![2].badgeValue = "Followers"
//self.tabBarItem.= UIColor.blue
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // self.selectedIndex = 0
    }
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if(item == tabBar.items![1])
//        {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadImageTabBarVC") as! UploadImageTabBarVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//
//        else if(item == tabBar.items![2])
//        {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UsersVC") as! UsersVC
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }

    
}
