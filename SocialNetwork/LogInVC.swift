//
//  LogInVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 27/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class LogInVC: UIViewController
{

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet var passwordTextFild: UITextField!
    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

     let  tap =  UITapGestureRecognizer(target: self, action: Selector("hidekeyboard") )
    self.view.addGestureRecognizer(tap)
        
        
        logInButton.layer.cornerRadius =  logInButton.frame.size.height/2
        logInButton.clipsToBounds = true
        
        passwordTextFild.layer.cornerRadius = passwordTextFild.frame.size.height/2
        passwordTextFild.clipsToBounds = true
        
        
        emailTextField.layer.cornerRadius = emailTextField.frame.size.height/2
        emailTextField.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        
        
        UINavigationBar.appearance().isTranslucent = true
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
      //  self.navigationController?.navigationBar.backgroundColor = UIColor.clear//(red: 118, green: 57, blue: 59, alpha: 1)
        
        
    }

  
    @IBAction func logInButton(_ sender: Any)
    {
        if emailTextField.text != "" || passwordTextFild.text != ""
        {SVProgressHUD.show()
            SVProgressHUD.setDefaultMaskType(.clear)
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextFild.text! , completion:
                {
                    (user,error)in if let error = error
                {
                print(error.localizedDescription)
                    SVProgressHUD.dismiss()
                    Alert.pop(VC: self, message: error.localizedDescription, action: "OK")
                }
                else if self.emailTextField.text == ""
                {
                 Alert.pop(VC: self, message: "Enter Your Email", action: "OK")
                }
                    
                    else if self.passwordTextFild.text == ""

                    {
                          Alert.pop(VC: self, message: "Enter password", action: "OK")
                    }
                
                if let user = user
                {
                      SVProgressHUD.dismiss()
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tab") as! TabBarController
                    self.navigationController?.pushViewController(vc, animated: true)
                 //   self.present(vc, animated: true, completion: nil)
                   //     let destinationVC = tabCtrl as! TabBarController
                   // self.show(destinationVC, sender: nil)
                }
                
                })
        
        }
     }
func hidekeyboard()
{
    self.emailTextField.endEditing(true)
    self.passwordTextFild.endEditing(true)
    }

    @IBAction func backAction(_ sender: Any)
    {

        self.navigationController?.popViewController(animated: true)
    }
}
