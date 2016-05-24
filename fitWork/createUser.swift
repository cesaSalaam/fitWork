//
//  createUser.swift
//  fitWork
//
//  Created by Lifoma Salaam on 5/4/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit

class createUser: UIViewController {

    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    
    @IBAction func createClicked(sender: AnyObject) {
        createUser(self.email.text!, password: self.password.text!, username: self.username.text!)
    }
    //MARK: user function
    func createUser(email: String, password: String, username: String){
        //function that creates user
        if (username != "" && email != "" && password != ""){
            // Set Email and Password for the New User.
            FirebaseService.firebase.userRef.createUser(email, password: password, withValueCompletionBlock: { error, result in
                if error != nil {
                    print(error.description)
                    // alert user that there was an error
                    self.signupErrorAlert("Oops!", message: "Having some trouble creating your account. Try again.")
                } else {
                    
                    // Create and Login the New User with authUser
                    FirebaseService.firebase.userRef.authUser(email, password: password, withCompletionBlock: {
                        err, authData in
                        
                        let user = ["provider": authData.provider!, "email": email, "username": username]
                        
                        // Seal the deal in DataService.swift.
                        FirebaseService.firebase.createNewAccount(authData.uid, user: user)
                    })
                    // Enter the app.
                    self.performSegueWithIdentifier("toMain", sender: nil)
                }
            })
        } else {
            //Alert user that there was an error
            signupErrorAlert("Oops!", message: "Don't forget to enter your email, password, and a username.")
        }
    }
    
    func signupErrorAlert(title: String, message: String) {
        // Called upon signup error to let the user know signup didn't work.
        //creates an alert
        let alert = UIAlertView(
            title: NSLocalizedString("Create account failed", comment: "Sign account failed"),
            message: message,
            delegate: nil,
            cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
        )
        alert.show()
    }
    
    override func viewWillAppear(animated: Bool) {
        let border = CALayer()
        
        let border2 = CALayer()
        
        let border3 = CALayer()
        
        let width = CGFloat(2.0)
        
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: username.frame.size.height - width, width:  username.frame.size.width, height: username.frame.size.height)
        
        border.borderWidth = width
        username.layer.addSublayer(border)
        username.layer.masksToBounds = true
        
        border2.borderColor = UIColor.darkGrayColor().CGColor
        border2.frame = CGRect(x: 0, y: password.frame.size.height - width, width:  password.frame.size.width, height: password.frame.size.height)
        
        border2.borderWidth = width
        password.layer.addSublayer(border2)
        password.layer.masksToBounds = true
        
        border3.borderColor = UIColor.darkGrayColor().CGColor
        border3.frame = CGRect(x: 0, y: email.frame.size.height - width, width:  email.frame.size.width, height: email.frame.size.height)
        
        border3.borderWidth = width
        email.layer.addSublayer(border3)
        email.layer.masksToBounds = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        //resigns keyboard when background is tapped
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
}
