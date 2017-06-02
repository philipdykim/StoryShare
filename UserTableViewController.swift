//
//  UserTableViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Matthew Oh on 6/1/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class UserTableViewController: UITableViewController {

    var usernames = [String]()
    
    @IBAction func logout(_ sender: Any) {
    
        PFUser.logOut()
        
        performSegue(withIdentifier: "logoutSegue", sender: self)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = PFUser.query()
        
        query?.findObjectsInBackground(block: { (objects, error) in
            
            if error != nil {
            
                print(error ?? "Error")
            
            } else if let users = objects {
                
                self.usernames.removeAll()
  
                for object in users {
        
                    if let user = object as? PFUser {
                      
                        self.usernames.append(user.username!)
                        
                    }
                    
                    //print(object)
                    
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
        
        return usernames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        print("Return cell?")
        
        
        cell.textLabel?.text = usernames[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
