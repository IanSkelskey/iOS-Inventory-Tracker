//
//  ViewController.swift
//  InventoryDemo
//
//  Created by Ian Skelskey on 3/6/22.
//

import UIKit

class ViewController: UIViewController {
    var inventory:[Item] = []{didSet{print(inventory.map({$0.quantity}))}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inventory = createTestInventory(itemCount: Int.random(in: 1..<20))
        
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 32)
        title.text = "Inventory Tracker"
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let controlMode = UISegmentedControl(items: ["View", "Edit"])
        controlMode.selectedSegmentIndex = 0
        controlMode.addTarget(self, action: #selector(controlModeChanged), for: .valueChanged)
        
        let itemsTable = UITableView()
        
        let submit = UIButton.init(type: .system)
        
        submit.setTitle("Submit", for: .normal)
        submit.layer.cornerRadius = 8
        submit.backgroundColor = UIColor.systemGreen
        submit.setTitleColor(UIColor.white, for: .normal)
        
        
        controlMode.translatesAutoresizingMaskIntoConstraints = false
        itemsTable.translatesAutoresizingMaskIntoConstraints = false
        submit.translatesAutoresizingMaskIntoConstraints = false
        
        itemsTable.register(InventoryCell.self, forCellReuseIdentifier: "InventoryCell")
        itemsTable.register(InventoryHeader.self, forHeaderFooterViewReuseIdentifier: "InventoryHeader")
        itemsTable.dataSource = self
        itemsTable.delegate = self

        
        view.addSubview(itemsTable)
        view.addSubview(controlMode)
        view.addSubview(title)
        view.addSubview(submit)
        
        title.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        controlMode.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 8).isActive = true
        controlMode.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        submit.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        submit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        submit.heightAnchor.constraint(equalToConstant: 40).isActive = true
        submit.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        itemsTable.topAnchor.constraint(equalTo: controlMode.bottomAnchor, constant: 8).isActive = true
        itemsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        itemsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        itemsTable.bottomAnchor.constraint(equalTo: submit.topAnchor, constant: -8).isActive = true
        

        // Do any additional setup after loading the view.
    }

    @objc func controlModeChanged(){
        // Define what happens when the segmented control's value is changed
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // How many rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventory.count
    }
    
    // Describe Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell", for: indexPath) as! InventoryCell
        let item = inventory[indexPath.row]
        cell.set(item: item)
        cell.indexPath = indexPath
        cell.setDelegate(delegate: self)
        return cell
    }
    
    // Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Set Table Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "InventoryHeader")
    }
    // Set height for table header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

// Create test data
func createTestInventory(itemCount: Int) -> [Item] {
    var items = [Item]()
    var i = 0
    
    while(i < itemCount) {
        items.append(Item(SKU: i, name: "Item \(i + 1)", quantity: Int.random(in: 0..<15)))
        i += 1
    }
    
    return items
}



extension ViewController:InventoryCellDelegate{
    func inventoryCell(_ cell: InventoryCell, didUpdateItem item: Item) {
        guard let indexPath = cell.indexPath else {return}
        inventory[indexPath.item] = item
    }
    
    
}


