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
        self.hideKeyboardWhenTappedAround() 
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
//                    self.consoleBox.textColor = UIColor.green
//                    self.consoleBox.text = "Success! Please go back to Sign in (:"
                    Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
                        if let firebaseError = error {
                            print(firebaseError.localizedDescription)
                            self.consoleBox.text = firebaseError.localizedDescription
                            return
                        }
                    })
                    
                    
                    
                    let alert = UIAlertController(title: "Sign up successful", message: "You're all set up!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: { action in
                        let ref = Database.database().reference()
                        let userID : String = (Auth.auth().currentUser?.uid)!
                        
                        let currUser = ref.child("users").child(userID)
                        
                        currUser.observeSingleEvent(of: .value, with: { (snapshot) in
                            let currChildren = snapshot.value as! NSDictionary
                            let currUserStatus = currChildren.value(forKey: "userStatus") as! String
                            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            var newView: UINavigationController
                            if currUserStatus == "Buyer" {
                                newView = storyboard.instantiateViewController(withIdentifier: "BuyerView") as! UINavigationController
                            } else {
                                newView = storyboard.instantiateViewController(withIdentifier: "SellerView") as! UINavigationController
                            }
                            self.present(newView, animated: true, completion: nil)
                        })
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    self.toLogin.isHidden = false
                    self.ref.child("users").child(user!.uid).setValue(["userStatus": self.userStatus.titleForSegment(at: self.userStatus.selectedSegmentIndex), "name": self.nameField.text])
                    //print("Success")
                })
            } else {
                //self.consoleBox.text = "Passwords not matching."
                let alert = UIAlertController(title: "Passwords don't match", message: "Please try again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    

}
