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
    @IBOutlet weak var cellButton: UIButton!
    var ref:DatabaseReference?
    
    @IBAction func acceptClick(_ sender: Any) {
        ref = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        self.ref?.child("users").child(userID).child("messages").child(chatID).setValue(menuItem.text)
        ref?.child("offers").child(offerID).removeValue()
        offers.remove(at: cellButton.tag)
    }

}
