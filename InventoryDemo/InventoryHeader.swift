//
//  InventoryHeader.swift
//  InventoryDemo
//
//  Created by Ian Skelskey on 3/6/22.
//

import UIKit

class InventoryHeader: UITableViewHeaderFooterView {
    let name = UILabel()
    let quantity = UILabel()
    let step = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        quantity.translatesAutoresizingMaskIntoConstraints = false
        step.translatesAutoresizingMaskIntoConstraints = false
        
        name.text = "Name"
        quantity.text = "Qty"
        step.text = "Step"
        
        self.contentView.addSubview(name)
        self.contentView.addSubview(quantity)
        self.contentView.addSubview(step)
        
        
        
        name.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        step.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        step.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -48).isActive = true
        
        quantity.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        quantity.trailingAnchor.constraint(equalTo: step.leadingAnchor, constant: -44).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
