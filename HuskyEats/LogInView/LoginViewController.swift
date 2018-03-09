//
//  LoginViewController.swift
//  HuskyEats
//
//  Created by Sean Lee on 3/8/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var consoleBox: UILabel!
    
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
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let restaurantView: RestaurantView = storyboard.instantiateViewController(withIdentifier: "RestaurantView") as! RestaurantView
        self.present(restaurantView, animated: true, completion: nil)
    }
    
    
}
