//
//  NewsFeedVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 21/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
//import Firebase
import FirebaseDatabase

import Kingfisher
import Firebase

class NewsFeedVC: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate
   {
   

    
    @IBOutlet weak var collectionView: UICollectionView!
    var feed = [Post](){
    didSet{
    self.collectionView.reloadData()
        }}//pehhle feed empty h jab view did load call hua feed.count zero hoga n collection view reload nh hoga . viewdid appear pe feed fill ho gya hoga n fee.count b so collection view reload ho jaega
    private let cellHeight:CGFloat = 300

    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("newsviewDidLoad")
        let nib = UINib(nibName: "NewsFeedCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "NewsFeedCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
    
        // Do any additional setup after loading the view.
           }
//    override func viewDidAppear(_ animated: Bool) {
//        //print("viewDidAppear")
//        super.viewDidAppear(animated)
//        print("newsfeedviewdidappear")
//        if self.feed != nil
//        {
//            PKHUD.sharedHUD.show()
//            UsersVCService.retrievePosts(_abc:
//                {
//
//                incomingList in
//                    print(incomingList.count)
//                self.feed = incomingList
//                self.collectionView.reloadData()
//                print("newsFeedincomingList\(incomingList)nomber\(self.feed.count)")
//                PKHUD.sharedHUD.hide()
//            })
//
//        }
//    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UsersVCService.retrievePosts(_abc:
            {
                
                incomingList in
                
                if incomingList.count == 0
                {
                    print("tableView empty")
                    // self.feed = nil
                    self.feed = incomingList
                }
             
                else
                {
                     self.collectionView.reloadData()
                     self.feed = incomingList
                }
                print(incomingList.count)
                

                
        })
        
    }
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("NewsFeedpritnno of sections")
          return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {   print("***in cellForItemAtIndexPath")
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
        cell.nameLabel.text =  self.feed[indexPath.row].author
        let url = URL(string:feed[indexPath.row].pathToImage)

        cell.imageLabel.kf.setImage(with: url)
       // cell.imageLabel.image = UIImage(named: "Car1.png")
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    

    @IBAction func ProfileButton(_ sender: Any)
    {

        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        show(destinationVC, sender: nil)
        
        
    }
}
 

    

