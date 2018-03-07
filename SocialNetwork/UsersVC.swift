//
//  UsersVC.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 23/02/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import Firebase

import Kingfisher

class UsersVC: UIViewController, UITableViewDelegate,UITableViewDataSource,followButtonDelegate
{
    @IBOutlet var tableView: UITableView!
    var users = [User]() {
        didSet {
            self.tableView.reloadData()
        }
    }
     override func viewDidLoad()
     {
        super.viewDidLoad()
        print("users 5")
        let nib = UINib(nibName: "UsersNibCellTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "UsersNibCellTableViewCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
   
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // users = nil
        print("viewDidAppear")
        if self.users != nil
        {
            //PKHUD.sharedHUD.show()
        
        UsersVCService.retrieveUser({incomingList in
            self.users = incomingList
            print("incomigList")
            //print(incomingList)
           // self.hideHUD()
           // PKHUD.sharedHUD.hide()
            }
        )
    }
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print("cell for row at index path")
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersNibCellTableViewCell", for: indexPath) as! UsersNibCellTableViewCell
      
    
        print("ddd")
      //  cell.isUserInteractionEnabled = No
        cell.label.text = users[indexPath.row].userName
       // cell.profileImage.image =
        let url = URL(string: users[indexPath.row].urlToImage)
        cell.profileImage.kf.setImage(with: url)
        cell.id = indexPath.row//1
        cell.delegate = self//2
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("no of rows in sec")
        print(users.count)
        return users.count == 0 ? 0 : users.count
    }
    
    

    func followButtonTapped(at index:Int)//5
    {
        print("followButtonTapped")
        var toggleState = 1
        //1 = not following
        var uid = Auth.auth().currentUser!.uid
        let ref = Database.database().reference()
        let key = ref.child("users").childByAutoId().key
        //to unfollow
        
            var isfollower = false
            ref.child("users").child(uid).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with:
            { snapshot in
                //current user me ek following folder banega
                print("in closure")
            if let following = snapshot.value as? [String:AnyObject]
            {
                print("following loop 1")
                for (ke,value) in following
                {   print("in following loop 2")
                    if value as! String == self.users[index].userID
            //selected user ki uid following folder k ek user ki uid se match kari to vo already follow kar rha h.nh to loop k bahar
                    {   
                        isfollower = true
                        ref.child("users").child(uid).child("following/\(ke)").removeValue()
                        ref.child("users").child(self.users[index].userID).child("following/\(ke)").removeValue()
                      
                    }
                }
            }
           //current user is not a follower of the user it selected
                if !isfollower
                {
                print("isfollower loop")
                let following = ["following/\(key)" : self.users[index].userID]
                let followers = ["followers/\(key)": uid]
                    ref.child("users").child(uid).updateChildValues(following)
                    ref.child("users").child(self.users[index].userID).updateChildValues(followers)
                    
                }
                
                }
    )
        
        
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let ediAction = UITableViewRowAction(style: .default, title: "Yoyo") { (action, indexpath) in
            //
        }
        ediAction.backgroundColor = UIColor.purple
        return [ediAction]

    }
    
}

    
    
   
