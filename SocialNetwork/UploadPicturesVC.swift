//
//  UploadPicturesVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 28/03/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
import Firebase
import Photos



class UploadPicturesVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet weak var SelectImage: UIButton!
    
    @IBOutlet weak var Post: UIButton!
    var picker = UIImagePickerController()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        
        let status = PHPhotoLibrary.authorizationStatus()
        if (status == PHAuthorizationStatus.authorized)
        {
          print("kk")  // Access has been granted.
        }
            
        else if (status == PHAuthorizationStatus.denied)
        {
            // Access has been denied.
        }
            
        else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized)
                {
                    
                }
                    
                else {
                    
                }
            })
        }
            
        else if (status == PHAuthorizationStatus.restricted)
        {
            // Restricted access - normally won't happen.
        }
        
    }
    
    @IBAction func selectImageButton(_ sender: Any)
    {
    
    picker.allowsEditing = true
    picker.sourceType = .photoLibrary
    self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            self.previewImage.image = image
        self.SelectImage.isHidden = true
        self.Post.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }
  
   
    @IBAction func postAction(_ sender: Any)
    {
        let uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
       let storage = Storage.storage().reference(forURL: "gs://photogenyc-83d0d.appspot.com")
  //      let storage = Storage.storage().reference(forURL: "gs://photogenyc-83d0d.appspot.com")//Storage.storage().reference(forURL: "gs://photogenyc-83d0d.appspot.com")
        let key = ref.child("posts").childByAutoId().key
        // it will generate a string for each post
        let imageRef = storage.child("posts").child(uid).child("\(key).jpg")//creates a folder posts in it uid in it a file with nake key.jpg
        let data = UIImageJPEGRepresentation(self.previewImage.image!, 0.6) as NSData!
        
        let uploadTask = imageRef.putData(data! as Data, metadata: nil)//imageRef.put(data!, metadata:nil)
               { (metadata, error) in
            if error != nil
            {
           print(error?.localizedDescription)
               return
           }
                //get the url of the file created  with jpf extension
        imageRef.downloadURL(completion: {(url, error) in
        if let url = url
        {//?
          let feed = [
            "userID": uid ,
            "pathToImage": url.absoluteString,
            "likes": 0,
            "author": Auth.auth().currentUser!.displayName!,
            "postID":key] as [String : Any]
            
            let postFeed = ["\(key)" : feed]
            ref.child("posts").updateChildValues(postFeed)
            self.dismiss(animated: true, completion: nil)
            }
        })
        }
        uploadTask.resume()

    }
    
}

