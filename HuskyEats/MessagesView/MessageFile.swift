//
//  MessageFile.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/12/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import Foundation
import UIKit

class MessageFile {
    var offerItem: String
    var chatID: String
    
    init(chatID: String, offerItem: String) {
        self.offerItem = offerItem
        self.chatID = chatID

    }
}
