//
//  FirstVC.swift
//  SocialNetwork
//
//  Created by Keertika on 10/02/18.
//  Copyright © 2018 Keertika Gupta. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {
    @IBOutlet weak var facebookButton: UIButton!
    
    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.navigationController?.navigationBar.isHidden = true
        facebookButton.layer.cornerRadius = facebookButton.frame.size.height/2
        facebookButton.clipsToBounds = true
        
        logInButton.layer.cornerRadius = logInButton.frame.size.height/2
        logInButton.clipsToBounds = true
    }


    @IBAction func logInAction(_ sender: Any) {
        
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "LogInVC")
        
        self.navigationController?.pushViewController(destinationVC!, animated: true)
    }

    @IBAction func facebookAction(_ sender: Any) {
    }
    @IBAction func signUpAction(_ sender: Any)
    {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "enterEmailVC") as! enterEmailVC
        show(destinationVC, sender: nil)

        
    }
    
}
