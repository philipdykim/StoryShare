//
//  ProfileTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 6/27/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class ProfileTableViewController: UITableViewController {
    
    var users = [String:String]()
    var username = String()
    var occupation = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if let users = objects {
                
                self.users.removeAll()
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        if user.objectId == PFUser.current()?.objectId {
                            
                            self.username = user["profilename"] as! String
                
                            self.occupation = user["occupation"] as! String
                            
                            self.tableView.reloadData()
                        
                            
                        }
                        
                    }
                }
            }
            
            
            
        })
        
       
        

       
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //query user profile information
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
        
        
            cell.userLabel.text = username
            cell.occupationLabel.text = occupation
            
    
    
        return cell
    }

  


}
