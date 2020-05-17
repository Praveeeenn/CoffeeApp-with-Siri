//
//  CoffeeOrderDataManager.swift
//  HotCoffee
//
//  Created by Praveen on 17/05/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Foundation
import Intents

class CoffeeOrderDataManager {
    
    func getAllOrders() -> [Order] {
        var orders = [Order]()
        if let userDefaults = UserDefaults(suiteName: "group.com.praveen.hotcoffee.shared") {
            
            if let ordersData = userDefaults.data(forKey: "Orders") {
                orders = try! JSONDecoder().decode([Order].self, from: ordersData)
            }
        }
        return orders
    }
    
    func saveOrder(order :Order) {
        var orders = getAllOrders()
        orders.append(order)
        if let userDefaults = UserDefaults(suiteName: "group.com.praveen.hotcoffee.shared")
        {
            let ordersData = try! JSONEncoder().encode(orders)
            userDefaults.set(ordersData, forKey: "Orders")
        }
        donate(order: order)
    }
    
    private func donate(order: Order) {
        let interaction = INInteraction(intent: order.intent, response: nil)
        
        interaction.donate { (error) in
            if let error = error {
                print("ERRORRR:---- \(error)")
            }
        }
    }
    
}
