//
//  Item.swift
//  InventoryDemo
//
//  Created by Ian Skelskey on 3/6/22.
//

import UIKit

class Item {
    var SKU: Int
    var name: String
    var quantity: Int

    init() {
        SKU = -1
        name = "not set"
        quantity = -1
    }
    
    init(SKU: Int, name: String, quantity: Int) {
        self.SKU = SKU
        self.name = name
        self.quantity = quantity
    }
}
