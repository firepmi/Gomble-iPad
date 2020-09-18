//
//  FactoryView.swift
//  Gomble
//
//  Created by mobileworld on 8/27/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class FactoryView: BaseView {
    
    @IBOutlet weak var nameTextField: RoundedTextField!
    
    @IBOutlet weak var phoneTextField: RoundedTextField!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var informationTextView: RoundedTextView!
    
    override func setNibName() {
        nibName = "FactoryView"
    }
    override func initView() {
        getData()
    }
    func getData(){
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.getFactory(param: param) { json in
            if json["success"].boolValue {
                print(json["message"].stringValue)
                self.refreshView(json: json["res"])
            }
            else {
                print(json["message"].stringValue)
            }
        }
    }
    func updateData(completion:((JSON)->Void)?){
        var param = [String:String]()
        param["name"] = nameTextField.text
        param["email"] = emailTextField.text
        param["phone"] = phoneTextField.text
        param["information"] = informationTextView.text
        param["techpack_id"] = Globals.techpackID
        APIManager.updateFactory(param: param, completion: completion)
    }
    func refreshView(json:JSON){
        nameTextField.text = json["name"].stringValue
        emailTextField.text = json["email"].stringValue
        phoneTextField.text = json["phone"].stringValue
        informationTextView.text = json["information"].stringValue
    }
}

