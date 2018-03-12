//
//  Restaurant.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/7/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import Foundation
import UIKit

class Restaurant {
    var image: String
    var label: String
    var currKey: String
    
    init(image: String, label: String, currKey: String) {
        self.image = image
        self.label = label
        self.currKey = currKey
    }
}
