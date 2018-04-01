//
//  UsersVCService.swift
//  SocialNetwork
//
//  Created by Keertika Gupta on 13/03/17.
//  Copyright © 2017 Keertika Gupta. All rights reserved.
//

import Foundation
import Firebase

class UsersVCService
{
    var users = [User]()
    static var posts = [Post]()
    static var following = [String]()
    
    class func retrieveUser(_ abc: @escaping ([User]) -> Void)
{
    var fetchedList = [User]()
    print("retreive user")
    let ref = Database.database().reference()
    ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
        let user = snapshot.value as? [String:Any]
        var str = [String]()
        
        //self.users.removeAll()
        for(_, value) in user!
        {
            if let newValue = value as? Dictionary<String, AnyObject>
                //   if let uid = (value as! [String:String])["uid"] as? String
                //if let uid = value["uid"] as? String
            {
                print("if let new value")
                print(newValue)
                let uid = newValue ["uid"] as! String
                if uid != Auth.auth().currentUser!.uid
                {
                    print("if uid")
                    let userToShow = User()
                    print("newValues\(String(describing: newValue["uid"]))")
                    if let fullName = newValue["fullname"] as? String, let imagePath = newValue["urlToImage"] as? String, let userName = newValue["username"] as? String, let _ = newValue["password"]  as? String
                    {
                      //  print("usename")
                        str.append(fullName)
                        
                        userToShow.fullName = fullName
                      //  print(fullName)
                        userToShow.imagePath = imagePath
                        userToShow.userID = uid
                        userToShow.userName = userName
                        userToShow.urlToImage = imagePath
                        fetchedList.append(userToShow)
                        abc(fetchedList)
                        print("fetcheList")
                       // print(fetchedList)
                       // print("users\(self.users)")
                        print("user to show\(userToShow)")
                    }
                    
                    
                    
                }
            }
        }//user
  //  }
            })//snapshot
   
    
}//func
    class func retrievePosts(_abc: @escaping ([Post])-> Void)
    { self.posts = []
        self.following = []
        //print("retreivePosts")
        let ref = Database.database().reference() // event type is value

        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { snapshot in
            let  users = snapshot.value as! [String:AnyObject]
            //extract it in a dictionary
            for(_,value) in users  //value is the any object from dictionary
            {   //print("-value")
                 if let uid = value ["uid"] as? String
                 {
                    if uid == Auth.auth().currentUser!.uid // if he is the current user then check if he is following any one
                    {  ///print("uid")
                    if let followingUsers = value["following"] as? [String : String]// users ka ek element value me h usme se following nikal k dict me cast karenge
                    {
                        //print("if let following user")
                        for(_,user) in followingUsers
                        {
                            self.following.append(user)// add all the users in following folder of current user into following array
                          //  print("followingusers\(following)")
                        }
                    }
                        else
                    {
                        self.following.append(Auth.auth().currentUser!.uid)
                        }
                            // add the post of current user
                    ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with:
                        { snap in
                            
                            
                         
                           if (snap.exists())
                            {
                             let postsSnap = snap.value as! [String:AnyObject]
                            for(_,post) in postsSnap
                            {
                                print("-post")
                                print(post["userID"])
                                if let userID = post["userID"] as? String //post folder me se ek element value me h
                                {
                                    for each in self.following //following array me se ek userid nikalenge
                                    {print("each")
                                        if each == userID //agar following user ki user id posts me jo user h unse match kar jae
                                        //ek post userID ko ek user k sare following se comapre karenge
                                        {
                                           let posst = Post()
                                            if let author = post["author"] as? String , let likes = post["likes"] as? Int, let pathToImage = post["pathToImage"] as? String, let postID = post["userID"] as? String
                                            {
                                                posst.author = author
                                                posst.likes = likes
                                                posst.pathToImage = pathToImage
                                                posst.userID = userID
                                                posst.postID = postID
                                                print("pppppp\(posst)")
                                                self.posts.append(posst)
                                            }
                                        }
                                        
                                    }
                                    
                                    }//for post
                                
                            
                            }
                            
                        _abc(posts)
                            print("POSTS\(posts)")
                                
                            }
                            
                            else
                           
                            {
                                var emptyArray : [Post] = []
                                print("no post to show")
                                _abc(emptyArray)
                                
                            }
                            })  //snap
                        }
                    }
                }

})//snapshot
}
    
    func signOut()
    {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
