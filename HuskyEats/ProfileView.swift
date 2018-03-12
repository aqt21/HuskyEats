//
//  ProfileView.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/12/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileView: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var statusField: UISegmentedControl!
    var ref:DatabaseReference?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let currUser = ref?.child("users").child(userID)
        
        currUser?.observeSingleEvent(of: .value, with: { (snapshot) in
            
            let currChildren = snapshot.value as! NSDictionary
            let currStatus = currChildren.value(forKey: "userStatus") as? String
            self.nameField.text = currChildren.value(forKey: "name") as? String
            if currStatus == "Buyer" {
                self.statusField.selectedSegmentIndex = 0
            } else {
                self.statusField.selectedSegmentIndex = 1
            }
            
        })
    }
    @IBAction func confirmProfile(_ sender: UIButton) {
        let userID : String = (Auth.auth().currentUser?.uid)!
        let selectedStatus : String? = self.statusField.titleForSegment(at: self.statusField.selectedSegmentIndex)
        self.ref?.child("users").child(userID).setValue(["userStatus": selectedStatus, "name": self.nameField.text])
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var newView: UINavigationController
        if selectedStatus == "Buyer" {
            newView = storyboard.instantiateViewController(withIdentifier: "BuyerView") as! UINavigationController
        } else {
            newView = storyboard.instantiateViewController(withIdentifier: "SellerView") as! UINavigationController
        }
        self.present(newView, animated: true, completion: nil)
    }
    
    
}
