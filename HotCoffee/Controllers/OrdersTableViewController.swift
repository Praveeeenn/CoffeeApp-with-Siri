//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Praveen on 7/7/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import Foundation
import UIKit
import Intents
import CoreSpotlight
import CoreServices


class OrdersTableViewController : UITableViewController {
    
    var orders :[Order] = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    @IBAction func unwindToOrdersTableViewController(segue:UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showOrderDetails" {

            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }

            let order = self.orders[indexPath.row]

            let placeOrderTVC = segue.destination as! PlaceOrderTableViewController
            placeOrderTVC.order = order

        }
    }
    
    func addOrder(order :Order) {
        
        self.orders.append(order)
        donateOrderActivityWith(order: order)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func donateOrderActivityWith(order: Order) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = self.orders[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        cell.textLabel?.text = order.coffee.name
        cell.imageView?.image = UIImage(named: order.coffee.imageURL)
        cell.detailTextLabel?.text = "$\(order.total)"
        
        return cell
        
    }

}
