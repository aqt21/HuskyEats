//
//  Restaurant.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/7/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import Foundation
import UIKit

class MenuItem {
    var title: String
    var description: String
    var price: Double
    var currKey: String
    
    init(title: String, description: String, price: Double, currKey: String) {
        self.title = title
        self.description = description
        self.currKey = currKey
        self.price = price
    }
}
