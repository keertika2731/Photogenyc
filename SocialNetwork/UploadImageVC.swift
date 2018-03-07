//
//  UploadImageVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 21/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
class UploadImageVC: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet var postImage: UIButton!
    @IBOutlet var selectImageButton: UIButton!
    @IBOutlet var previewImage: UIImageView!
    
    var picker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
picker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            self.previewImage.image = image
            selectImageButton.isHidden = true
            postImage.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func selectPressed(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        self.present(picker , animated: true,completion: nil)
    }
    
    

    @IBAction func postPressed(_ sender: Any)
    {
        let uid = Auth.auth().currentUser!.uid //userid of the current uset
        let ref = Database.database().reference() // refernce to database
        let storage = Storage.storage().reference(forURL:"gs://photogenyc-83d0d.appspot.com")
        
        let key = ref.child("posts").childByAutoId().key // a new folder in database named posts . It will give a key to every post
        let imageRef = storage.child("posts").child(uid).child("\(key).jpg")
        
        let data = UIImageJPEGRepresentation(self.previewImage.image!, 0.6)
        let uploadTask = imageRef.putData(data!, metadata: nil) //imageRef.put(data! , metadata: nil)
        {
            (metadata , error) in
            if error != nil
            {
                print(error!.localizedDescription)
                return
            }
            
            imageRef.downloadURL(completion: {(url, error) in
                if let url = url
                {
                    let feed = ["userID:": uid,
                                "pathToImage": url.absoluteString,
                                "likes":0] as [String : Any] as [String : Any]
                    let postFeed = ["\(key)" : feed]
                    ref.child("posts").updateChildValues(postFeed)
                    self.dismiss(animated: true, completion: nil)
                }
                })
        
    }
    uploadTask.resume()
    }}
