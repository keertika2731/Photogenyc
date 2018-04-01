//
//  AlertViewController.swift
//  SocialNetwork
//
//  Created by Keertika on 29/03/18.
//  Copyright © 2018 Keertika Gupta. All rights reserved.
//

import UIKit

class Alert: UIAlertController
{
    
    
  class func pop(VC:UIViewController,message:String,action:String)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
        VC.present(alert, animated: true, completion: nil)
    }


}
