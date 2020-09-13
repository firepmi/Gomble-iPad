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
        factoryTextField.text = json["factory"].floatValue.currencyFormattedStr()
        feeTextField.text = json["fee"].floatValue.currencyFormattedStr()
        deliveryTextField.text = json["delivery"].floatValue.currencyFormattedStr()
        calcTotal()
    }
    func updateData(){
        var param = [String:String]()
        param["factory"] = "\(factoryTextField.text?.currencyValue() ?? 0)"
        param["materials"] = "25"//materialsLabel.text
        param["fee"] = "\(feeTextField.text?.currencyValue() ?? 0)"
        param["delivery"] = "\(deliveryTextField.text?.currencyValue() ?? 0)"
        param["total"] = "\(totalLabel.text?.currencyValue() ?? 0)"
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
        var total:Float = 20
        total += (factoryTextField.text?.currencyValue())!
        total += (feeTextField.text?.currencyValue())!
        total += (deliveryTextField.text?.currencyValue())!
        totalLabel.text = total.currencyFormattedStr()
    }
}

