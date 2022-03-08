//
//  ViewController.swift
//  InventoryDemo
//
//  Created by Ian Skelskey on 3/6/22.
//

import UIKit

class ViewController: UIViewController {
    var inventory:[Item] = []{didSet{print(inventory.map({$0.quantity}))}}
    let logo = UIImage(named: "logo.png")
    let logoView = UIImageView()
    let titleLabel = UILabel()
    let controlMode = UISegmentedControl(items: ["View", "Edit"])
    let itemsTable = UITableView()
    
    let submit = UIButton.init(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.inventory = createTestInventory(itemCount: Int.random(in: 1..<20))
        
        logoView.image = logo
        
        titleLabel.font = UIFont.systemFont(ofSize: 32)
        titleLabel.text = "Inventory Tracker"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        
        controlMode.selectedSegmentIndex = 0
        controlMode.addTarget(self, action: #selector(controlModeChanged), for: .valueChanged)
        

        
        // submit.setTitle("Submit", for: .normal)
        // submit.layer.cornerRadius = 8
        // submit.backgroundColor = UIColor.systemGreen
        // submit.setTitleColor(UIColor.white, for: .normal)
        
        
        controlMode.translatesAutoresizingMaskIntoConstraints = false
        itemsTable.translatesAutoresizingMaskIntoConstraints = false
        // submit.translatesAutoresizingMaskIntoConstraints = false
        
        itemsTable.register(InventoryCell.self, forCellReuseIdentifier: "InventoryCell")
        itemsTable.register(InventoryHeader.self, forHeaderFooterViewReuseIdentifier: "InventoryHeader")
        itemsTable.dataSource = self
        itemsTable.delegate = self

        
        view.addSubview(itemsTable)
        view.addSubview(controlMode)
        view.addSubview(titleLabel)
        // view.addSubview(submit)
        view.addSubview(logoView)
        
        logoView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 8).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        controlMode.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        controlMode.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // submit.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // submit.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        // submit.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // submit.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        itemsTable.topAnchor.constraint(equalTo: controlMode.bottomAnchor, constant: 8).isActive = true
        itemsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        itemsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        itemsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        

        
        // Do any additional setup after loading the view.
    }

    @objc func controlModeChanged(){
        var current_mode = ""
        if (controlMode.selectedSegmentIndex == 0) {
            current_mode = "view"
            toggleCellEditing(active: false)
            
            // Deactivate Stepper
            // Deactivate TextField
            // Remove Submit Button
        }else{
            current_mode = "edit"
            toggleCellEditing(active: true)
            // Activate Stepper
            // Activate TextField
            // Add Submit Button
        }
        
        print(current_mode)
        // Define what happens when the segmented control's value is changed
        if (current_mode == "view"){
            
        } else { //"edit"
            
        }
    }
    
    func toggleCellEditing(active:Bool) {
        var i = 0
        while(i < inventory.count){
            print("updating item \(i)")
            let indexPath = IndexPath(row: i, section: 0)
            itemsTable.cellForRow(at: indexPath)?.isUserInteractionEnabled = active
            i += 1
        }
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


