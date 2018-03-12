//
//  SellerTableView.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/11/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Firebase
var offers : [SellerItem] = []

class SellerTableView: UIViewController {
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
   

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        handle = ref?.child("offers").observe(.childAdded, with: { (snapshot) in
            let currChildren = snapshot.value as! NSDictionary
            let currItem = currChildren.value(forKey: "item") as! String
            let currRestaurant = currChildren.value(forKey: "restaurant") as! String
            let itemPrice: String = currChildren.value(forKey: "price") as! String
            let currItemPrice: Double = Double(itemPrice)!
            let currOfferPrice = currChildren.value(forKey: "offerPrice") as! Double
            let currPercent = currChildren.value(forKey: "offerPercent") as! String
            let currUserID = currChildren.value(forKey: "offerUser") as! String
            let chatID = currChildren.value(forKey: "offerChat") as! String
            let offerID = currChildren.value(forKey: "offerID") as! String
            let currOffer = SellerItem(item: currItem, percent: currPercent, itemPrice: currItemPrice, offerPrice: currOfferPrice,  offerRestaurant: currRestaurant, offerUserID: currUserID, chatID: chatID, offerID: offerID)
            offers.append(currOffer)
            self.tableView.reloadData()

        })
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension SellerTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let offer = offers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SellerCell
        cell.menuItem.text = offer.menuItem
        cell.offerPercent.text = offer.offerPercent
        cell.offerPrice.text = String(offer.offerPrice)
        cell.itemPrice.text = String(offer.itemPrice)
        cell.offerRestaurant.text = offer.offerRestaurant
        cell.offerUserID = offer.offerUserID
        cell.chatID = offer.chatID
        cell.cellButton.tag = indexPath.row
        cell.offerID  = offer.offerID
        return cell
    }

    
}

