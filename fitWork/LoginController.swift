//
//  LoginController.swift
//  fitWork
//
//  Created by Lifoma Salaam on 4/27/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    @IBOutlet var usernameTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func loginClicked(sender: AnyObject) {
        
        
        let email = usernameTextField.text
        
        let passwordText = passwordTextField.text
        
        if email != "" && passwordText != "" {
            
            // Login with the Firebase's authUser method
            
            FirebaseService.firebase.userRef.authUser(email, password: passwordText, withCompletionBlock: { error, authData in
                
                if error != nil {
                    // if there is an error an alert will be displayed
                    print(error)
                    self.loginErrorAlert("Oops!", message: "Check your username and password.")
                } else {
                    // Be sure the correct uid is stored.
                    
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    // Enter the app!
                    self.performSegueWithIdentifier("toMainController", sender: nil)
                }
            })
            
        } else {
            // There was a problem so an alert is shown
            loginErrorAlert("Oops!", message: "Don't forget to enter your email and password.")
        }
    }
    


    func loginErrorAlert(title: String, message: String) {
        // Called upon login error to let the user know login didn't work.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
    
        presentViewController(alert, animated: true, completion: nil)
    }

    override func viewWillAppear(animated: Bool){
        let border = CALayer()
        let border2 = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: self.usernameTextField.frame.size.height - width, width:  self.usernameTextField.frame.size.width, height: self.usernameTextField.frame.size.height)
        
        border.borderWidth = width
        self.usernameTextField.layer.addSublayer(border)
        self.usernameTextField.layer.masksToBounds = true
        
        border2.borderColor = UIColor.darkGrayColor().CGColor
        border2.frame = CGRect(x: 0, y: self.passwordTextField.frame.size.height - width, width:  self.passwordTextField.frame.size.width, height: self.passwordTextField.frame.size.height)
        
        border2.borderWidth = width
        self.passwordTextField.layer.addSublayer(border2)
        self.passwordTextField.layer.masksToBounds = true
    }
    
    
    
}
