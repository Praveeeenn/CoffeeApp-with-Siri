//
//  Order.swift
//  HotCoffee
//
//  Created by Praveen on 7/7/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import Foundation

enum CoffeeSize :Int {
    case small = 0
    case medium = 1
    case large = 2
}

class Order {
    
    var identifier :UUID
    var coffee :Coffee
    var total :Double
    var size :CoffeeSize
    
    init(coffee :Coffee, total :Double, size :CoffeeSize = .medium, identifier :UUID = UUID()) {
        self.coffee = coffee
        self.total = total
        self.size = size
        self.identifier = identifier
    }
}




