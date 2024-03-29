//
//  FavoritesViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Matthew Oh on 7/3/17.
//  Copyright © 2017 Parse. All rights reserved.
//

//FUCKFUCKFUCK

import UIKit
import Parse

class FavoritesViewController:  UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var FavoritesCollectionView: UICollectionView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    var messages = [String]()
    var postID = [String]()
    var imageFiles = [PFFile]()
    var username = ""
    var indexdata = Int()
    var post_id = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.FavoritesCollectionView.delegate = self
        self.FavoritesCollectionView.dataSource = self
        
        //usernameLabel.text = username
        
        var query = PFQuery(className: "Bookmarks")
        query.whereKey("Bookmarkers", equalTo: PFUser.current()?.objectId)
        
        query.findObjectsInBackground(block: { (objects, error) in
            
            if let bookmarks = objects {
                
                for object in bookmarks {
                    
                    self.postID.append(object["Bookmarked_Post"] as! String)
                    
                    
                }
                
            }
            
            let getBookmarkedPosts = PFQuery(className: "Posts")
            
            getBookmarkedPosts.whereKey("postid", containedIn: self.postID) //Parse query with array
            
            getBookmarkedPosts.findObjectsInBackground(block: { (objects, error) in
                
                if let bookmarkedPosts = objects {
                    
                    for object in bookmarkedPosts {
                        
                        if let bookmarkedPost = object as? PFObject {
                            
                            self.imageFiles.append(bookmarkedPost["imageFile"] as! PFFile)
                            
                            self.messages.append(bookmarkedPost["message"] as! String)

                            self.post_id.append(object["postid"] as! String)
                            
                            self.FavoritesCollectionView.reloadData()
                            
                            print(self.messages)
                        }
                        
                    }
                    
                }
                
            })
            
        })
        
    }
    
    
    
    // Do any additional setup after loading the view.
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! FavoritesCollectionViewCell
        
        cell.storyButton.tag = indexPath.row
        cell.storyButton.addTarget(self, action: #selector(ProfileViewController.nextpage), for: .touchUpInside)
        
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            
            if let imageData = data {
                
                if let downloadedImage = UIImage(data: imageData) {
                    
                    cell.favoritesImageView.image = downloadedImage
                    
                }
                
            }
            
        }
        
        cell.favoritesImageView.image = UIImage(named: "My-Story-Book-Maker-Icon.png")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected row is", indexPath.row)
    }
    
    //function for the button on image to perform segue and pass indexpath data
    
    func nextpage(_ sender: UIButton) {
        
        self.indexdata = sender.tag
        self.performSegue(withIdentifier: "tostory1", sender: self)
        
    }
    
    // segue to pass indexpath data and postid data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tostory1" {
            
            let pvc = segue.destination as! StoryPageViewController
            pvc.postid.removeAll()
            pvc.postid = self.post_id
            pvc.indexdata = self.indexdata
            print(indexdata)
            print(post_id.count)
        }
    }
    
}
