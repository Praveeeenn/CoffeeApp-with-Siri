//
//  IntentHandler.swift
//  HotCoffeeIntents
//
//  Created by Praveen on 17/05/20.
//  Copyright © 2020 Mohammad Azam. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler: OrderCoffeeIntentHandling {
    func handle(intent: OrderCoffeeIntent, completion: @escaping (OrderCoffeeIntentResponse) -> Void) {
        
    }
    
    func resolveTotal(for intent: OrderCoffeeIntent, with completion: @escaping (OrderCoffeeTotalResolutionResult) -> Void) {
        
    }
    
    func resolveCoffee(for intent: OrderCoffeeIntent, with completion: @escaping (TypeResolutionResult) -> Void) {
        
    }
    
    func resolveSize(for intent: OrderCoffeeIntent, with completion: @escaping (CoffeSizeResolutionResult) -> Void) {
        
    }
    
    func provideTotalOptions(for intent: OrderCoffeeIntent, with completion: @escaping ([Double]?, Error?) -> Void) {
        
    }
    
    func provideCoffeeOptions(for intent: OrderCoffeeIntent, with completion: @escaping ([Type]?, Error?) -> Void) {
        
    }
    
    
}
