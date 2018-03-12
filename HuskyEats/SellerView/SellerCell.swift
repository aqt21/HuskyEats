//
//  SellerCell.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/12/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SellerCell: UITableViewCell {
    @IBOutlet weak var menuItem: UILabel!
    @IBOutlet weak var offerPercent: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var offerRestaurant: UILabel!
    var offerUserID: String!
    var chatID: String!
    var offerID: String!
    var parentView: UIViewController!
    @IBOutlet weak var cellButton: UIButton!
    var ref:DatabaseReference?
    
    @IBAction func acceptClick(_ sender: Any) {
        let alert = UIAlertController(title: "Confirm?", message: "Do you want to accept this offer?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: { action in
            toRemove = self.cellButton.tag
            self.ref = Database.database().reference()
            let userID : String = (Auth.auth().currentUser?.uid)!
            self.ref?.child("users").child(userID).child("messages").child(self.chatID).setValue(self.menuItem.text)
            self.ref?.child("offers").child(self.offerID).removeValue()
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
        parentView.present(alert, animated: true, completion: nil)
    }

}
