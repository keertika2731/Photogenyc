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
import SVProgressHUD


class UploadPicturesVC: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate,UIGestureRecognizerDelegate
{

    @IBOutlet var caption: UITextView!
    @IBOutlet weak var previewImage: UIImageView!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var SelectImage: UIButton!
    
    @IBOutlet weak var Post: UIButton!
    var picker = UIImagePickerController()
    var date = String()
    let calendar = Calendar.current
    
    var image:UIImage!
    {
        
       didSet
            {
                self.previewImage.image = image
                self.SelectImage.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // self.previewImage.image = nil
        
        caption.text = " Enter your caption...."
        caption.textColor = UIColor.lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
       // tap.delegate = self as! UIGestureRecognizerDelegate
        self.view.addGestureRecognizer(tap)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        caption.delegate = self
        self.caption.layer.borderWidth = 1
        self.caption.layer.borderColor = UIColor.black.cgColor
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)


        let now = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
         self.date = dateFormatter.string(from: now as Date)
    }
   
   @objc func hideKeyboard()
    {
        view.endEditing(true)
    }
    func keyboardWillShow()
    {
       scrollView.contentInset = UIEdgeInsetsMake(0,0,290,0)
    }
    
    
    func keyboardWillHide()
    {
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    @IBAction func selectImageButton(_ sender: Any)
    {
    
    picker.allowsEditing = true
    picker.sourceType = .photoLibrary
       // presentViewController(picker, animated: true, completion: nil)
        
    self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage
        {
        self.previewImage.image = image
            self.image = image
      //  self.SelectImage.isHidden = true
      //  self.Post.isHidden = false
        }
        picker.dismiss(animated: true, completion: nil)
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
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        let uploadTask = imageRef.putData(data! as Data, metadata: nil)//imageRef.put(data!, metadata:nil)
               { (metadata, error) in
            if error != nil
            {
           print(error?.localizedDescription)
                Alert.pop(VC: self, message: (error?.localizedDescription)!, action: "OK")
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
            "postID":key,
            "caption":self.caption.text,
            "date": self.date
            ] as [String : Any]
            
            let postFeed = ["\(key)" : feed]
            ref.child("posts").updateChildValues(postFeed)
          //  self.dismiss(animated: true, completion: nil)
            }
            
            SVProgressHUD.dismiss()
            // Alert pop up
            let alert = UIAlertController(title: "", message: "You post has been successfully uploaded", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                self.caption.text = nil
                self.previewImage.image = nil
                self.SelectImage.isHidden = false
                
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        })
        }
        uploadTask.resume()
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.scrollView.scrollRectToVisible(Post.frame, animated: true)
        if textView.textColor == UIColor.lightGray
        {
            textView.text = nil
            textView.textColor = UIColor.black
         
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty
            
        {
            textView.text = " Enter your caption...."
            textView.textColor = UIColor.lightGray
        }
    }
    
}

