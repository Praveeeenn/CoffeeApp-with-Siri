//
//  Order.swift
//  HotCoffee
//
//  Created by Praveen on 7/7/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import Foundation
import Intents

enum CoffeeSize :Int, Codable {
    case small = 0
    case medium = 1
    case large = 2
}

class Order: Codable {
    
    var identifier :UUID
    var coffee :Coffee
    var total :Double
    var size :CoffeeSize
    
    convenience init?(intent: OrderCoffeeIntent) {
        guard
            let total1 = intent.total,
            let coffeeINObject = intent.coffee
            else {
                return nil
        }
        
        let coffeeManager = CoffeeManager()
        let name1 = coffeeINObject.displayString
        let size1 = CoffeeSize(rawValue: intent.size.rawValue)!
        let coffee1 = coffeeManager.findByName(name: name1)!
         
        self.init(coffee: coffee1, total: Double(truncating: total1), size: size1, identifier: UUID())
    }
    
    init(coffee :Coffee, total :Double, size :CoffeeSize, identifier :UUID) {
        self.identifier = UUID()
        self.coffee = coffee
        self.total = total
        self.size = size
        self.identifier = identifier
    }
    
}

extension Order {
    public var intent: OrderCoffeeIntent {
        let orderCoffeeIntent = OrderCoffeeIntent()
        orderCoffeeIntent.total = NSNumber(value: self.total)
        orderCoffeeIntent.coffee = INObject(identifier: self.coffee.name, display: self.coffee.name) as? Type
        orderCoffeeIntent.setImage(INImage(named: self.coffee.imageURL), forParameterNamed: \.coffee)
        orderCoffeeIntent.size = CoffeSize(rawValue: self.size.rawValue + 1)!
        return orderCoffeeIntent
    }
}


