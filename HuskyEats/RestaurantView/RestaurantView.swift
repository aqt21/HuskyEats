//
//  RestaurantView.swift
//  HuskyEats
//
//  Created by Andrew Tran on 3/6/18.
//  Copyright © 2018 Andrew Tran. All rights reserved.
//

import UIKit
import Firebase

var selectedRestaurant: String = ""
class RestaurantView: UIViewController {
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    var restaurants : [Restaurant] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        handle = ref?.child("Restaurants").observe(.childAdded, with: { (snapshot) in
            let currChildren = snapshot.value as! NSDictionary
            let currImage = currChildren.value(forKey: "imgurl") as! String
            let currTitle = currChildren.value(forKey: "title") as! String
            let restaurantKey = snapshot.key
            let currRestaurant = Restaurant(image: currImage, label: currTitle, currKey: restaurantKey)
            self.restaurants.append(currRestaurant)
            self.tableView.reloadData()
        
        })
        print(restaurants)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
}

extension RestaurantView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = restaurants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! RestaurantCell
        
        if let restaurantImageUrl: String = restaurant.image {
            let url = URL(string: restaurantImageUrl)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                let backgroundQueue = DispatchQueue(label: "aqt21.github.HuskyEats",
                                                    qos: .background,
                                                    target: nil)
                backgroundQueue.async {
                    cell.imageView?.image = UIImage(data: data!)
                }
            }).resume()
            
        }
        cell.restaurantLabel.text = restaurant.label
        cell.restaurantKey = restaurant.currKey
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurant = restaurants[indexPath.row].currKey
        performSegue(withIdentifier: "restaurantToMenu", sender: selectedRestaurant)
    }
    
}
