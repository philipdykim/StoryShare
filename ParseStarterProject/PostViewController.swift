//
//  PostViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 6/25/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var postImage: UIImageView!
    
    @IBOutlet weak var titleText: UITextField!
    
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
    
    
    @IBAction func nextpage(_ sender: Any) {
        
        //perform segue, but need to add in error check (if textfield or image field is blank)
            
            performSegue(withIdentifier: "topagetwo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondcontroller = segue.destination as! SecondPostViewController
        secondcontroller.firstmessage = storyTextview.text
        secondcontroller.firstimage = postImage.image!
        secondcontroller.storytitle = titleText.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hide keyboard when a user touches outside textfield
    //Added by Matt on 7/2/2017
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true) //This will hide the keyboard
    }
    //Added by Matt on 7/2/2017
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


