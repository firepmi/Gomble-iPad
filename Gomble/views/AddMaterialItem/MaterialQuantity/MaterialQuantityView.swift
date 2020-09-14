//
//  MaterialQuantityView.swift
//  Gomble
//
//  Created by mobileworld on 8/26/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

@IBDesignable
class MaterialQuantityView: BaseView {
    
    @IBOutlet weak var quantityTextField: RoundedTextField!
    @IBOutlet weak var pricePerItemTextField: RoundedTextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    override func setNibName() {
        nibName = "MaterialQuantityView"
    }
    override func initView() {
        quantityTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        pricePerItemTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        pricePerItemTextField.text = Float(50).currencyFormattedStr()
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == pricePerItemTextField, let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
        calcTotal()
    }
    func calcTotal(){
        var quantity:Float = 0
        if quantityTextField.text != "" {
            quantity = Float(quantityTextField.text!) ?? 0
        }
        let total = quantity * (pricePerItemTextField.text?.currencyValue())!
        totalPriceLabel.text = total.currencyFormattedStr()
    }
}

