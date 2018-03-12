///Users/andrewtran/Desktop/HuskyEats-sean/HuskyEats/SignUpView/SignUpViewController.swift
//  LoginViewController.swift
//  HuskyEats
//
//  Created by Sean Lee on 3/8/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var consoleBox: UILabel!
    var ref:DatabaseReference?
    
    ////////////////////////////////////////////////////////////////////////////
    // This will sign the user in,
    // Sign in is currently only available with basic email and password.
    //
    // Error handling is done via Firebase, (only displays type of error)/
    //////////////////
    @IBAction func signIn(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: {(user, error) in
                if let firebaseError = error {
                    print(firebaseError.localizedDescription)
                    self.consoleBox.text = firebaseError.localizedDescription
                    return
                }
               self.toRestaurantView()
            })
            print("Success!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        ref = Database.database().reference()
    }
    
    /////////////////////////////////////////////////////////////////////////////
    // This will override and skip the sign up page if the user has already
    // Logged on.
    //
    // Currently commented out, since there is no way to come back to sign in
    // screen without the nav bar working.
    //
    // * Uncomment when sign out is implemented.
    //////////////////
//    override func viewDidAppear(_ animated: Bool) {
//        if Auth.auth().currentUser != nil {
//            self.toRestaurantView()
//        }
//    }
    
    ////////////////////////////////////////////////////////////////////////
    // If sign in is successful it will take the user to the
    // Restaurant view screen.
    //
    //////////////////
    func toRestaurantView(){
        let userID : String = (Auth.auth().currentUser?.uid)!
        
        let currUser = ref?.child("users").child(userID)
        
        currUser?.observeSingleEvent(of: .value, with: { (snapshot) in
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
        
        
        
        
    }
    
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
