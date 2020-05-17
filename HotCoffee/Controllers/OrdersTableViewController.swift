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
    
    private var coffeeDataManager = CoffeeOrderDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        populateOrders()
    }
    
    private func populateOrders() {
        self.orders = coffeeDataManager.getAllOrders()
        self.tableView.reloadData()
    }
    
    @IBAction func unwindToOrdersTableViewController(segue:UIStoryboardSegue) {
        populateOrders()
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
    
//    func addOrder(order :Order) {
//
//        self.orders.append(order)
////        donateOrderActivityWith(order: order)
//        self.donate(order: order)
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
    
//    private func donate(order: Order) {
//        let interaction = INInteraction(intent: order.intent, response: nil)
//
//        interaction.donate { (error) in
//            if let error = error {
//                print("ERRORRR:---- \(error)")
//            }
//        }
//
//    }
    
//    private func donateOrderActivityWith(order: Order) {
//        let orderActivity = NSUserActivity(activityType: "com.praveen.HotCoffee-hotcoffee-activity-type")
//        orderActivity.isEligibleForSearch = true
//        orderActivity.isEligibleForPrediction = true
//        orderActivity.title = order.coffee.name
//        orderActivity.suggestedInvocationPhrase = "Coffe Time"
//        orderActivity.userInfo = ["Key": "Value"]
//
//        let attribute = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
//        attribute.contentDescription = "Get it while its hot!"
//        attribute.thumbnailData = UIImage(named: order.coffee.imageURL)?.pngData()
//        self.userActivity = orderActivity
//        self.userActivity?.becomeCurrent()
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let order = self.orders[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        cell.textLabel?.text = order.coffee.name
        cell.imageView?.image = UIImage(named: order.coffee.imageURL)
        cell.detailTextLabel?.text = "$\(order.total)"
        
        return cell
        
    }

}
