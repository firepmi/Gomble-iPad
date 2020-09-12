//
//  PriceView.swift
//  Gomble
//
//  Created by mobileworld on 8/27/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class PriceView: BaseView {
    @IBOutlet weak var factoryTextField: RoundedTextField!
    @IBOutlet weak var materialsLabel: UILabel!
    @IBOutlet weak var feeTextField: RoundedTextField!
    @IBOutlet weak var deliveryTextField: RoundedTextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func setNibName() {
        nibName = "PriceView"
    }
    override func initView() {
        getData()
        factoryTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        feeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        deliveryTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    func getData(){
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.getPrice(param: param) { json in
            if json["success"].boolValue {
                print(json["message"].stringValue)
                self.refreshView(json: json["res"])
            }
            else {
                self.makeToast(json["message"].stringValue)
            }
        }
    }
    func refreshView(json:JSON){
        factoryTextField.text = String(format: "%.2f", json["factory"].floatValue).currencyInputFormatting()
        feeTextField.text = String(format: "%.2f", json["fee"].floatValue).currencyInputFormatting()
        deliveryTextField.text = String(format: "%.2f", json["delivery"].floatValue).currencyInputFormatting()
        calcTotal()
    }
    func updateData(){
        var param = [String:String]()
        param["factory"] = String(describing: factoryTextField.text?.currencyValue())
        param["materials"] = "25"//materialsLabel.text
        param["fee"] = String(describing: feeTextField.text?.currencyValue())
        param["delivery"] = String(describing: deliveryTextField.text?.currencyValue())
        param["total"] = String(describing: totalLabel.text?.currencyValue())
        param["techpack_id"] = Globals.techpackID
        
        APIManager.updatePrice(param: param) { json in
            if json["success"].boolValue {
                print(json["message"].stringValue)
            }
            else {
                self.makeToast(json["message"].stringValue)
            }
        }
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
        calcTotal()
    }
    func calcTotal(){
        var total:Double = 20
        total += (factoryTextField.text?.currencyValue())!
        total += (feeTextField.text?.currencyValue())!
        total += (deliveryTextField.text?.currencyValue())!
        totalLabel.text = String(format: "%.2lf", total).currencyInputFormatting()
    }
}

