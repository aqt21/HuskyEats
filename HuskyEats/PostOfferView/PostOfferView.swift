//
//  PostOfferView.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/12/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class PostOfferView: UIViewController {
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var userOffer: UITextField!
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        print(selectedItem)
        let selectedFood = ref?.child("Restaurants").child(selectedRestaurant).child("Menu").child(selectedItem)
        
        selectedFood?.observeSingleEvent(of: .value, with: { (snapshot) in

            let currChildren = snapshot.value as! NSDictionary
            let currPrice = currChildren.value(forKey: "price") as! Double
            self.itemName.text = currChildren.value(forKey: "title") as? String
            self.itemPrice.text = String(currPrice)
            self.itemDescription.text = currChildren.value(forKey: "description") as? String
        })
        
    }
    
    @IBAction func offerClick(_ sender: UIButton) {
        let currRef = self.ref?.child("offers").childByAutoId()
        let currOfferKey = currRef?.key
        let chatRef = self.ref?.child("chats").childByAutoId()
        let offerText: String? = userOffer.text
        if let finalOffer = offerText, let offerAmount = Double(finalOffer) {
            let userID : String = (Auth.auth().currentUser?.uid)!
            let price: String? = itemPrice.text
            if let priceClarified = price, let priceInDouble = Double(priceClarified){
                currRef?.setValue(["restaurant": selectedRestaurant, "item": selectedItem, "price": self.itemPrice.text, "offerPercent": userOffer.text, "offerUser": userID, "offerPrice": offerAmount / 100 * priceInDouble, "offerChat": chatRef?.key, "offerID": currOfferKey])
            }
            self.ref?.child("users").child(userID).child("messages").child((chatRef?.key)!).setValue(selectedItem)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a number as your offer", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
