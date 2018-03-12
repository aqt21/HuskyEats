//
//  MessagesView.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/12/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Firebase

var selectedMessage: String = ""
class MessagesView: UIViewController {
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    var messages : [MessageFile] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID : String = (Auth.auth().currentUser?.uid)!
        ref = Database.database().reference()
        handle = ref?.child("users").child(userID).child("messages").observe(.childAdded, with: { (snapshot) in
                let currItem = MessageFile(chatID: snapshot.key as! String, offerItem: snapshot.value as! String)
                self.messages.append(currItem)
            self.tableView.reloadData()
            
        })
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension MessagesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MessageCell

        cell.chatID = String(message.chatID)
        cell.transactionItem.text = message.offerItem
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMessage = messages[indexPath.row].chatID
        performSegue(withIdentifier: "messagesToChat", sender: selectedRestaurant)
    }
    
}
