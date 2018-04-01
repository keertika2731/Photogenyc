//
//  enterEmailVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 19/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit

class enterEmailVC: UIViewController {

    @IBOutlet var nextButtonOutlet: UIButton!
    
    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
nextButtonOutlet.layer.cornerRadius = nextButtonOutlet.frame.size.height/2
        nextButtonOutlet.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        self.view.addGestureRecognizer(tap)
        
    }
    
    func hideKeyboard()
    {
        self.emailTextField.endEditing(true)
    }


    

    @IBAction func nextButton(_ sender: Any)
    {
        if self.emailTextField.text == nil
        {
            Alert.pop(VC: self, message: "Enter your email", action: "OK")
        }
        
        else
        {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "enterNameVC") as! enterNameVC
        show(destinationVC, sender: nil)
        destinationVC.email = emailTextField.text
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        
     
        
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
        
    }
    
   
    
}
