//
//  enterNameVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 19/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit

class enterNameVC: UIViewController {
    
  
    var email: String?
    @IBOutlet var nextButton: UIButton!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
print("enter name 3")
self.nextButton.layer.cornerRadius = self.nextButton.frame.size.height/2
        
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        
        self.view.addGestureRecognizer(tap)
    }

func hideKeyboard()
{
    self.nameTextField.endEditing(true)
    self.passwordTextField.endEditing(true)
    }

   
    @IBAction func next(_ sender: Any)
    {
        if self.nameTextField.text == nil
        {
            Alert.pop(VC: self, message: "Enter your name", action: "OK")
        }
        
        else
        {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "EnterUserNameVC") as! EnterUserNameVC
        show(destinationVC, sender: nil)
        destinationVC.email = email
        destinationVC.name = nameTextField.text
        destinationVC.password = passwordTextField.text
    }
    }
   
    @IBAction func signInButton(_ sender: Any) {
        
         self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
}
