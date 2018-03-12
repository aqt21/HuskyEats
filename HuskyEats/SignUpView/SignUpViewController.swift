//
//  SignUpViewController.swift
//  HuskyEats
//
//  Created by Sean Lee on 3/8/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var consoleBox: UILabel!
    @IBOutlet weak var toLogin: UIButton!
    @IBOutlet weak var userStatus: UISegmentedControl!
    @IBOutlet weak var nameField: UITextField!
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    /////////////////////////////////////////////////////////////////////////////
    // Creates account in Firebase,
    // Sign up is currently only available with basic email and password.
    // (Many other options available through firebase that we can consider).
    //
    // Error handling is done via Firebase, (only displays type of error)/
    //////////////////
    @IBAction func createAccount(_ sender: Any) {
        
        if  let email = emailField.text,
            let password = passwordField.text,
            let confirm = confirmField.text {
            
            if password == confirm {
                Auth.auth().createUser(withEmail: email, password: password, completion: {
                    user, error in
                    if let firebaseError = error{
                        self.consoleBox.text = firebaseError.localizedDescription
                        print(firebaseError.localizedDescription)
                        return
                    }
                    self.consoleBox.textColor = UIColor.green
                    self.consoleBox.text = "Success! Please go back to Sign in (:"
                    self.toLogin.isHidden = false
                    self.ref.child("users").child(user!.uid).setValue(["userStatus": self.userStatus.titleForSegment(at: self.userStatus.selectedSegmentIndex), "name": self.nameField.text])
                    //print("Success")
                })
            } else {
                self.consoleBox.text = "Passwords not matching."
            }
        }
        
    }
    

}
