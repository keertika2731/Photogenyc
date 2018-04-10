//
//  NewsFeedVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 21/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseDatabase

import Kingfisher
import Firebase

class NewsFeedVC: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate
   {
   

    
   
    @IBOutlet var caption: UILabel!
    var height : CGFloat!
    @IBOutlet weak var collectionView: UICollectionView!
    var feed = [Post](){
    didSet{
           // self.collectionView.delegate = self
    self.collectionView.reloadData()
        }}//pehhle feed empty h jab view did load call hua feed.count zero hoga n collection view reload nh hoga . viewdid appear pe feed fill ho gya hoga n fee.count b so collection view reload ho jaega
   // private let cellHeight:CGFloat = 300

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("newsviewDidLoad")
       
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 120)
        layout.scrollDirection = .horizontal
        
 //      collectionView.collectionViewLayout = layout
// self.collectionView.collectionViewLayout = self.collectionViewFlowLayout
    
        // Do any additional setup after loading the view.
        
        
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout { flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)//CGSize(1,1)
        
            
           }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.automaticallyAdjustsScrollViewInsets = false
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.clear)
        UsersVCService.retrievePosts(_abc:
            {
                
                incomingList in
                
                if incomingList.count == 0
                {
                    print("tableView empty")
                    // self.feed = nil
                    self.feed = incomingList
                    Alert.pop(VC: self, message: "No post to show", action: "OK")
                    SVProgressHUD.dismiss()
                }
             
                else
                {
                     self.collectionView.reloadData()
                     self.feed = incomingList
                    SVProgressHUD.dismiss()
                }
              //  print(incomingList.count)
                

                
        })
        
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        height = self.collectionView.collectionViewLayout.collectionViewContentSiz()>
//    }
//
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("NewsFeedpritnno of sections")
          return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {   print("***in cellForItemAtIndexPath")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
        cell.nameLabel.text =  self.feed[indexPath.row].author
        let url = URL(string:feed[indexPath.row].pathToImage)

        cell.imageLabel.kf.setImage(with: url)
       // cell.imageLabel.image = UIImage(named: "Car1.png")
        //     cell.shadowView.layer.masksToBounds = false
        cell.shadowView.layer.shadowColor = UIColor.black.cgColor
        cell.shadowView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.shadowView.layer.shadowRadius = 5
        cell.shadowView.layer.shadowOpacity = 0.9
           cell.shadowView.layer.masksToBounds = false
        
        cell.shadowView.layer.borderWidth = 1
        cell.shadowView.layer.borderColor = UIColor.black.cgColor
     cell.date.text = self.feed[indexPath.row].date
cell.caption.text = self.feed[indexPath.row].caption
       
        cell.frame.size.width = UIScreen.main.bounds.width * 0.9
        cell.frame.origin.x = UIScreen.main.bounds.width * 0.05
        cell.postID = self.feed[indexPath.row].postID
        if self.feed[indexPath.row].liked
        {
        cell.likeButton.setImage(UIImage(named:"like"), for: .normal)
        }
        cell.likeLabel.text = "\((self.feed[indexPath.row].likes)!) Likes "
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
//        cell.contentView.frame = CGRect(x:cell.contentView.frame.origin.x, y:cell.contentView.frame.origin.y, width:screenWidth, height:65.0)
//       // CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
//
//        cell.caption.preferredMaxLayoutWidth = 50
//        cell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        return cell
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        return
//    }

    
    

    @IBAction func ProfileButton(_ sender: Any)
    {

        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        show(destinationVC, sender: nil)
        
        
    }
    
    @IBAction func logOut(_ sender: Any)
    {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
 
    

}
 

    

