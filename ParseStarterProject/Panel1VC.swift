//
//  Panel1VC.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 7/11/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class Panel1VC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var storyImage: UIImageView!
    
    @IBOutlet weak var storyLabel: UILabel!
    
    var postid = [String]()
    var indexdata = Int()
    var imagefile = [PFFile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let query = PFQuery(className: "Posts")
        
        query.whereKey("postid", equalTo: postid[indexdata])
        
        query.findObjectsInBackground(block: { (objects, error) in
            
            if let posts = objects {
                
                for object in posts {
                    
                    if let post = object as? PFObject {
                        
                        if let storylabel = object["message"] as? String {
                            
                            self.storyLabel.text = storylabel
                            
                        }
                        
                        if let storyimage = object["imageFile"] as? PFFile {
                            
                            self.imagefile.append(storyimage)
                            
                            self.imagefile[0].getDataInBackground { (data, error) in
                                
                                if let imageData = data {
                                    
                                    if let downloadedImage = UIImage(data: imageData) {
                                        
                                        self.storyImage.image = downloadedImage
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
