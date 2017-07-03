//
//  FourthPostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 7/2/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class FourthPostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var storytitle = String()
    var firstimage = UIImage()
    var firstmessage = String()
    var secondimage = UIImage()
    var secondmessage = String()
    var thirdimage = UIImage()
    var thirdmessage = String()
    
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    @IBAction func chooseimageButton(_ sender: Any) {
        //pick image based on saved images in camera
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            postImage.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var storyTextview: UITextView!
    
    
    
    @IBAction func prevpage(_ sender: Any) {
        performSegue(withIdentifier: "backpagethree", sender: self)
        
    }
    
    
    @IBAction func postButton(_ sender: Any) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let post = PFObject(className: "Posts")
        
        post["message"] = firstmessage
        post["message2"] = secondmessage
        post["message3"] = thirdmessage
        post["message4"] = storyTextview.text
        post["username"] = PFUser.current()?.objectId!
        
        let imageData = UIImagePNGRepresentation(firstimage)
        let imageFile = PFFile(name: "image.png", data: imageData!)
        post["imageFile"] = imageFile
        
        let imageData2 = UIImagePNGRepresentation(secondimage)
        let imageFile2 = PFFile(name: "image2.png", data: imageData2!)
        post["imageFile2"] = imageFile2
        
        let imageData3 = UIImagePNGRepresentation(thirdimage)
        let imageFile3 = PFFile(name: "image3.png", data: imageData3!)
        post["imageFile3"] = imageFile3
        
        let imageData4 = UIImagePNGRepresentation(postImage.image!)
        let imageFile4 = PFFile(name: "image4.png", data: imageData4!)
        post["imageFile4"] = imageFile4
        
        post.saveInBackground { (success, error) in
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error != nil {
                
                self.createAlert(title: "Could not post yout story", message: "Please try again later")
                
            } else {
                
                self.createAlert(title: "Story Posted!", message: "Your story has been shared successfully")
                self.storyTextview.text = "Description of story here"
                self.postImage.image = UIImage(named: "My-Story-Book-Maker-Icon.png")
                
            }
            
        }

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = storytitle


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
