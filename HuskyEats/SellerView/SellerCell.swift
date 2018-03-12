//
//  SellerCell.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/12/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit

class SellerCell: UITableViewCell {
    @IBOutlet weak var menuItem: UILabel!
    @IBOutlet weak var offerPercent: UILabel!
    @IBOutlet weak var offerPrice: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var offerRestaurant: UILabel!
    var offerUserID: String!
    
    
}
