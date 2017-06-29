//
//  RegisterViewController.swift
//  ParseStarterProject-Swift
//
//  Created by Sewon Park on 6/25/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit
import Parse

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var activityIndicator = UIActivityIndicatorView()
    let picker = UIPickerView()
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var profileTextField: UITextField!
    @IBOutlet weak var occupationPicker: UIPickerView!
    @IBOutlet weak var occupationTextField: UITextField!
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showlogin", sender: self)
    }
    
    var occupation = ["Consultant", "Unemployed", "Marketer", "Analyst", "Retail", "None", "Other"]
    
    
    func createAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
         
            //self.dismiss(animated: true, completion: nil)
            //This code was causing the dismissal of RegisterViewController and returning back to ViewController
            
            print("Alert dismissed")
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return occupation.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return occupation[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        occupationTextField.text = occupation[row]
        self.view.endEditing(false)
        
        
    }
    
    
    @IBAction func createButton(_ sender: UIButton) {
        
        if emailTextField.text == "" || passwordTextField.text == "" || profileTextField.text == "" || occupationTextField.text == "" { //Checking if both email and password and occupation are provided
            
            createAlert(title: "Error in form", message: "Please fill in all fields above.")
            
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            let user = PFUser()
            
            user.username = emailTextField.text
            user.email = emailTextField.text
            user.password = passwordTextField.text
            user["profilename"] = profileTextField.text
            user["occupation"] = occupationTextField.text
            
            user.signUpInBackground(block: { (success, error) in
                
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if error != nil {
                    
                    var displayErrorMessage = "Please try again later."
                    
                    let error = error as NSError?
                    
                    if let errorMessage = error?.userInfo["error"] as? String {
                        
                        displayErrorMessage = errorMessage
                    }
                    
                    self.createAlert(title: "Signup Error", message: displayErrorMessage)
                    
                } else {
                    
                    print("User signed up")
                    
                    self.performSegue(withIdentifier: "showfeedfromregister", sender: self)
                    
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        occupationPicker.isHidden = true
        
        //binding textfield to picker
        occupationTextField.inputView = picker
        
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
