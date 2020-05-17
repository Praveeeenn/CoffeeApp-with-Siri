//
//  CoffeeManager.swift
//  HotCoffee
//
//  Created by Praveen on 17/05/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import UIKit

class CoffeeManager {
    
    func getAll() -> [Coffee] {
        return [
            Coffee(name: "Cappuccino", imageURL: "cappuccino", basePrice: 4.60),
            Coffee(name: "Iced Coffee", imageURL: "iced-coffee", basePrice: 3.50),
            Coffee(name: "Regular Coffee", imageURL: "regular-coffee", basePrice: 2.00)
        ]
    }
    
    func findByName(name: String) -> Coffee? {
        return getAll().first { (coffee) -> Bool in
            return coffee.name == name 
        }
    }
}
