//
//  PlaceOrderTableViewController.swift
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

class PlaceOrderTableViewController : UITableViewController {
    
    @IBOutlet weak var coffeeImageView :UIImageView!
    @IBOutlet weak var coffeeLabel :UILabel!
    @IBOutlet weak var coffeeSizeSegmentedControl :UISegmentedControl!
    @IBOutlet weak var totalLabel :UILabel!
    
    var orderActivity :NSUserActivity!
    
    var coffee :Coffee!
    var order :Order!
    private var total :Double = 0.0
    private var coffeeSize :CoffeeSize = .small
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        
        self.coffeeSizeSegmentedControl.addTarget(self, action: #selector(coffeeeSizeSelectionChanged), for: .valueChanged)
        
        populateCoffee()
    }
    
    @IBAction func placeOrder() {
        
        performSegue(withIdentifier: "unwindToOrdersTableViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let coffee = self.coffee else { return }

        let coffeeOrderDataManager = CoffeeOrderDataManager()
        
        let order = Order(coffee: coffee, total: self.total, size: self.coffeeSize, identifier: UUID())
        
        coffeeOrderDataManager.saveOrder(order: order)        
    }
    
    private func updateTotalLabel(coffeeSize :CoffeeSize) {
        guard let coffee = self.coffee else { return }
        switch coffeeSize {
            case .small:
                self.total = coffee.basePrice * 1.5
            case .medium:
                self.total = coffee.basePrice * 2.5
            case .large:
                self.total = coffee.basePrice * 3.5
        }
        
        self.coffeeSize = coffeeSize
        self.totalLabel.text = "$\(self.total)"
    }
    
    @objc func coffeeeSizeSelectionChanged(segmentedControl :UISegmentedControl) {
        guard let coffeeSize = CoffeeSize(rawValue: segmentedControl.selectedSegmentIndex) else { return }
        updateTotalLabel(coffeeSize: coffeeSize)
    }
    
    private func populateCoffee() {
        
        if self.order != nil {
            populateOrderDetails()
        } else {
            reviewOrder()
        }
    }
    
    private func populateOrderDetails() {
        
        self.coffeeLabel.text = self.order.coffee.name
        self.coffeeImageView.image = UIImage(named: self.order.coffee.imageURL)
        self.totalLabel.text = "$\(self.order.total)"
        self.coffeeSizeSegmentedControl.selectedSegmentIndex = self.order.size.rawValue
    }
    
    private func reviewOrder() {
        
        self.coffeeLabel.text = self.coffee.name
        self.coffeeImageView.image = UIImage(named: self.coffee.imageURL)
        self.totalLabel.text = "$\(self.coffee.basePrice * 1.5)"
        updateTotalLabel(coffeeSize: self.coffeeSize)
    }
    
}
