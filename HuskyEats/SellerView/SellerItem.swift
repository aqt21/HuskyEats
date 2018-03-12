//
//  SellerItem.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/12/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import Foundation
import UIKit

class SellerItem {
    var menuItem: String
    var offerPercent: String
    var itemPrice: Double
    var offerPrice: Double
    var offerRestaurant: String
    var offerUserID: String
    var chatID: String
    var offerID: String
    
    init(item: String, percent: String, itemPrice: Double, offerPrice: Double,  offerRestaurant: String, offerUserID: String, chatID: String, offerID: String) {
        self.menuItem = item
        self.offerPercent = percent
        self.itemPrice = itemPrice
        self.offerPrice = offerPrice
        self.offerRestaurant = offerRestaurant
        self.offerUserID = offerUserID
        self.chatID = chatID
        self.offerID = offerID
    }
}
