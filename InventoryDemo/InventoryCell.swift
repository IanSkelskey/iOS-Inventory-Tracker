//
//  InventoryCell.swift
//  InventoryDemo
//
//  Created by Ian Skelskey on 3/6/22.
//

import UIKit

class InventoryCell: UITableViewCell {
    let name: UILabel = UILabel()
    let SKU: UILabel = UILabel()
    let quantity: UITextField = UITextField()
    let stepper: UIStepper = UIStepper()
    var delegate: InventoryCellDelegate?
    var indexPath:IndexPath?
    var item:Item = Item()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style,reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.isUserInteractionEnabled = false // cells start in view mode (read only)
        
        SKU.font = UIFont.systemFont(ofSize: 12)
        
        stepper.minimumValue = 0
        stepper.maximumValue = 999
        stepper.autorepeat = false
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
        
        quantity.delegate = self
        quantity.addTarget(self, action: #selector(quantityValueChanged(sender:)), for: .editingChanged)
        
        // Toggle to false before setting up constraints for each UIView
        self.name.translatesAutoresizingMaskIntoConstraints = false
        self.SKU.translatesAutoresizingMaskIntoConstraints = false
        self.quantity.translatesAutoresizingMaskIntoConstraints = false
        self.stepper.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the subviews to the cell
        self.contentView.addSubview(name)
        self.contentView.addSubview(SKU)
        self.contentView.addSubview(quantity)
        self.contentView.addSubview(stepper)
        
        // Set name label constraints
        name.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        
        SKU.leadingAnchor.constraint(equalTo: name.leadingAnchor).isActive = true
        SKU.topAnchor.constraint(equalTo: name.bottomAnchor ,constant: 2).isActive = true
        
        stepper.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stepper.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        // Set quantity label constraints
        quantity.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        quantity.trailingAnchor.constraint(equalTo: stepper.leadingAnchor, constant: -5).isActive = true
        quantity.widthAnchor.constraint(equalToConstant: 30).isActive = true
        quantity.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
        
    }
    
    @objc func stepperValueChanged(sender:UIStepper) {
        // Update self.item.quantity based on UIStepper
        self.item.quantity = Int(stepper.value)
        quantity.text = "\(self.item.quantity)"
        delegate?.inventoryCell(self, didUpdateItem: self.item)
    }
    
    @objc func quantityValueChanged(sender:UITextField) {
        // Update self.item.quantity based on keyboard input
        guard let count = Int.init(quantity.text ?? "") else {return}
        self.item.quantity = count
        delegate?.inventoryCell(self, didUpdateItem: self.item)
        stepper.value = Double(count)
    }
    
    required init?(coder: NSCoder){
        return nil
    }
    
    func set(item: Item){
        self.item = item
        name.text = self.item.name
        quantity.text = "\(self.item.quantity)"
        SKU.text = "SKU: \(self.item.SKU)"
        stepper.value = Double(self.item.quantity)
    }
    
    func setDelegate(delegate:InventoryCellDelegate){
        self.delegate = delegate
    }
}

protocol InventoryCellDelegate {
    func inventoryCell(_ cell:InventoryCell, didUpdateItem item:Item)
}

extension InventoryCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let charset = CharacterSet(charactersIn: string)
        let acceptedChar = CharacterSet.decimalDigits
        
        if charset.isSubset(of: acceptedChar){
            return true
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = "\(self.item.quantity)"
    }
}
