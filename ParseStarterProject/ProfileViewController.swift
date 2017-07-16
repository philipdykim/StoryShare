//
//  ProfileViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 7/9/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var users = [String:String]()
    var username = String()
    var occupation = String()
    var postImage = [PFFile]()
    var messages = [String]()
    var postid = [String]()
    
    var indexdata = Int()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var postCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postCollection.delegate = self
        self.postCollection.dataSource = self
        
        //query user info onto top of page
        
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                self.users.removeAll()
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        if user.objectId == PFUser.current()?.objectId {
                            
                            self.username = user["profilename"] as! String
                            
                            self.occupation = user["occupation"] as! String
                            
                            self.userLabel.text = self.username
                            self.occupationLabel.text = self.occupation
                            
                            
                        }
                        
                    }
                }
            }
            
            
            
        })
        
        //query user posts onto collection view
        
        let query1 = PFQuery(className: "Posts")
        
        query1.whereKey("username", equalTo: (PFUser.current()?.objectId!)!)
        
        query1.findObjectsInBackground(block: { (objects, error) in
            
            if let posts = objects {
                
                for object in posts {
                    
                    if let post = object as? PFObject {
                        
                        self.postImage.append(object["imageFile"] as! PFFile)
                        
                        self.messages.append(object["message"] as! String)
                        
                        self.postid.append(object["postid"] as! String)
                        
                        self.postCollection.reloadData()
                    }
                }
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "selfposts", for: indexPath) as! ProfileCollectionViewCell
        
        
        cell.storyButton.tag = indexPath.row
        cell.storyButton.addTarget(self, action: #selector(ProfileViewController.nextpage), for: .touchUpInside)
        
        postImage[indexPath.row].getDataInBackground { (data, error) in
            
            if let imageData = data {
                
                if let downloadedImage = UIImage(data: imageData) {
                    
                    cell.postImage.image = downloadedImage
                }
            }
        }
        
        cell.postImage.image = UIImage(named: "My-Story-Book-Maker-Icon.png")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected row is", indexPath.row)
        
    }
    
    //function for the button on image to perform segue and pass indexpath data
    
    func nextpage(_ sender: UIButton) {
        
        self.indexdata = sender.tag
        self.performSegue(withIdentifier: "tostory", sender: self)
        
    }
    
    // segue to pass indexpath data and postid data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tostory" {
            
            let pvc = segue.destination as! StoryPageViewController
            pvc.postid.removeAll()
            pvc.postid = self.postid
            pvc.indexdata = self.indexdata
            print(indexdata)
            print(postid.count)
        }
    }
    
}
