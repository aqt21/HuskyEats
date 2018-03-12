//
//  MenuView.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/7/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Firebase

var selectedItem: String = ""
class MenuView: UIViewController {
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    var items : [MenuItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        handle = ref?.child("Restaurants").child(selectedRestaurant).child("Menu").observe(.childAdded, with: { (snapshot) in
            let currChildren = snapshot.value as! NSDictionary
            let currPrice = currChildren.value(forKey: "price") as! Double
            let currTitle = currChildren.value(forKey: "title") as! String
            let currDesc = currChildren.value(forKey: "description") as! String
            let currKey = snapshot.key
            let currItem = MenuItem(title: currTitle, description: currDesc, price: currPrice, currKey: currKey)
            self.items.append(currItem)
            self.tableView.reloadData()
            
        })
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension MenuView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuCell
        
       
        cell.itemPrice.text = String(item.price)
        cell.itemName.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItem = items[indexPath.row].currKey
        performSegue(withIdentifier: "menuToOffer", sender: selectedRestaurant)
    }
    
}
