//
//  CoffeeListingTableViewController.swift
//  HotCoffee
//
//  Created by Praveen on 7/7/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import Foundation
import UIKit

class CoffeeListingTableViewController : UITableViewController {
    
    private let coffeeList :[Coffee] = [Coffee(name :"Cappuccino", imageURL : "cappuccino", basePrice :4.50),
                                        Coffee(name: "Iced Coffee", imageURL: "iced-coffee", basePrice :3.50),
                                        Coffee(name: "Regular Coffee", imageURL: "regular-coffee", basePrice :2.00)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.coffeeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath)
        let coffee = self.coffeeList[indexPath.row]
        
        cell.textLabel?.text = coffee.name
        cell.imageView?.image = UIImage(named: coffee.imageURL)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        guard let placeOrderTVC = segue.destination as? PlaceOrderTableViewController else {
            fatalError("PlaceOrderTableViewController not found")
        }
        
        placeOrderTVC.coffee = self.coffeeList[indexPath.row]
        
    }
    
}
