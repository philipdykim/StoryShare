//
//  FeedTableTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 6/25/17.
//  Copyright © 2017 Parse. All rights reserved.
//

//FUCKFUCKFUCK

import UIKit
import Parse

class FeedTableTableViewController: UITableViewController {
    
    var users = [String:String]()
    var messages = [String]()
    var usernames = [String]()
    var postTitle = [String]()
    var postID = [String]()
    var imageFiles = [PFFile]()
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func bookmarkTapped(_ sender: Any) {
        
        let buttonPosition:CGPoint = (sender as AnyObject).convert(CGPoint.zero, to:self.tableView) //Get the position of button
        
        let indexPathRow = self.tableView.indexPathForRow(at: buttonPosition) //Get IndexPath of the button
        
        let cell = self.tableView.cellForRow(at: indexPathRow!) as! FeedTableViewCell //Get the current cell using the IndexPath
        
        let postToBookmark = cell.postIDLabel.text
        
        let query = PFQuery(className: "Bookmarks")
        query.whereKey("Bookmarkers", equalTo: PFUser.current()?.objectId)
        query.whereKey("Bookmarked_Post", equalTo: postToBookmark)
        
        query.findObjectsInBackground { (objects, error) in
            
            if let objects = objects {
                
                if objects.count > 0 {
                    
                    self.createAlert(title: "Error", message: "This story has been already bookmared.")
                    
                    print("Already bookmarked")
                    
                } else {
                    
                    self.createAlert(title: "Bookmarked", message: "This story has been bookmared. It is now in your Favorites.")
                    
                    let bookmark = PFObject(className: "Bookmarks")
                    bookmark["Bookmarked_Post"] = postToBookmark
                    bookmark["Bookmarkers"] = PFUser.current()?.objectId
                    bookmark.saveInBackground()
                    
                    print("Now bookmarked")
                }
                
            }
            
        }
        
        

    }
    

    @IBAction func logoutButton(_ sender: UIButton) {
        PFUser.logOut()
        
        performSegue(withIdentifier: "logoutSegue", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                self.users.removeAll()
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        self.users[user.objectId!] = user.username!
                        
                    }
                    
                }
                
            }
            
            let query = PFQuery(className: "Posts")
            
            // This block is used to filter the feed based on follows
            /*
             let getFollowedUserQuery = PFQuery(className: "Followers")
             
             getFollowedUserQuery.whereKey("followers", equalTo: (PFUser.current()?.objectId!)!)
             getFollowedUserQuery.findObjectsInBackground(block: { (objects, error) in
             
             if let followers = objects {
             
             for object in followers {
             
             if let follower = object as? PFObject {
             
             let followedUser = follower["following"] as! String
             
             query.whereKey("userid", equalTo: followedUser)
             */
            
            query.findObjectsInBackground(block: { (objects, error) in
                
                if let posts = objects {
                    
                    for object in posts {
                        
                        if let post = object as? PFObject {
                            
                            self.messages.append(post["message"] as! String)
                            
                            self.imageFiles.append(object["imageFile"] as! PFFile) //ImageFile is just a pointer here (haven't downloaded the image yet
                            self.usernames.append(self.users[post["username"] as! String]!)
                            
                            self.postID.append(post["postid"] as! String)
                            
                            self.postTitle.append(post["title"] as! String)
                            
                            self.tableView.reloadData()
                            
                            //print(self.postID)
                            
                        }
                        
                    }
                    
                }
                
            })
            /*
             
             }
             
             }
             
             }
             
             }) */
            
        })
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell //Cast it as FeedTableViewContoller
        
        imageFiles[indexPath.row].getDataInBackground { (data, error) in
            
            if let imageData = data {
                
                if let downloadedImage = UIImage(data: imageData) {
                    
                    cell.storyCoverImage.image = downloadedImage
                    
                }
                
            }
            
        }
        
        cell.storyCoverImage.image = UIImage(named: "My-Story-Book-Maker-Icon.png")
        
        cell.userNameLabel.text = usernames[indexPath.row]
        
        cell.storySummaryLabel.text = messages[indexPath.row]
        
        cell.titleLabel.text = postTitle[indexPath.row]
        
        cell.postIDLabel.text = postID[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messages.count
    }
    
}
