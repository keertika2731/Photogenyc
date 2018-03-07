//
//  EnterUserNameVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 19/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
class EnterUserNameVC: UIViewController  , UIImagePickerControllerDelegate , UINavigationControllerDelegate
{
    @IBOutlet var signUpButton: UIButton!
    var email:String?
    var name:String?
    var password:String?
    let picker = UIImagePickerController()
    var userStorage: StorageReference!
    var ref : DatabaseReference!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var signUOutlet: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
   // self.picker.view.layer.cornerRadius = self.picker.view.frame.size.height/2
        self.signUOutlet.layer.cornerRadius = self.signUOutlet.frame.size.height/2
        
        picker.delegate = self
        let storage = Storage.storage().reference(forURL: "gs://photogenyc-83d0d.appspot.com")
        userStorage = storage.child("users") // creating a folder users
        ref = Database.database().reference()
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
        let tap = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        self.view.addGestureRecognizer(tap)
    

    }
    func hideKeyboard()
    {
        self.usernameTextField.endEditing(true)
        self.usernameTextField.endEditing(true)
        
    }
    
    @IBAction func selectImageButton(_ sender: Any)
    {picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        present(picker, animated:true , completion: nil)
    }
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImage.image = image
        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signInAction(_ sender: Any)
    {

        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    
    }
    
    @IBAction func signUp(_ sender: Any)
    {
        
        if usernameTextField.text == nil
        {
            let alertController = UIAlertController(title: "Error", message: "Please Enter a username", preferredStyle: .alert)
            let defaulAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaulAction)
            self.present(alertController , animated: true, completion: nil)
            
        }
        
      
        else
        {
            Auth.auth().createUser(withEmail: email!, password: password!,completion: { (user,error) in
                if let error = error
                {
                    print(error.localizedDescription)
                }
               
                if let user = user
                {
                    let changeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
                    changeRequest.displayName = self.usernameTextField.text!
                    changeRequest.commitChanges(completion: nil)
                    
                    let imageRef = self.userStorage.child("\(user.uid).jpg") //in users folder creating jpg file with user id
                    let data = UIImageJPEGRepresentation(self.profileImage.image!, 0.5)//parsing image as data
                    let uploadTask = imageRef.putData(data!, metadata: nil)//imageRef.put(data!, metadata:nil,completion :
                        {(metadata,err) in
                        if error != nil
                            {
                                print(err!.localizedDescription)
                            }
                        imageRef.downloadURL(completion:{(url,er) in
                            if err != nil
                            {
                                print(er!.localizedDescription)
                            }
                            if let url = url
                            {
                               // print("***&&&&&*")
                               // print("userid- \(user.uid)")
                               // print("fullname\(self.usernameTextField.text)")
                              //  print("url to im\( url.absoluteString)")
                                
                               // print ("kkkkk\(self.ref.child ("users"))")
                             
                                let userInfo: [String: Any] = ["uid" : user.uid , "username": self.usernameTextField.text! , "urlToImage": url.absoluteString , "password":self.password , "fullname":self.name]
                                self.ref.child("users").child(user.uid).setValue(userInfo)  //if it does not exxist it creates a folder users in database in it creates
                                print("you have signed up")
                                            //self.show(destinationVC, sender: nil)
                               
              print("email entered is\(self.email)")
                                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tab") as! TabBarController
                                self.navigationController?.pushViewController(vc, animated: true)

                            }
                        })
                    }
        uploadTask.resume()
}
            
 } )
      
          //  let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "UsersVC") as! UsersVC
           // self.show(destinationVC, sender: nil)
        }
        
      
    }
        

    
}



