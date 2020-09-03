//
//  SelectTypeViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/13/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

class SelectTypeViewController: UIViewController {

    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var designerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customerView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
        designerView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
    }
    @IBAction func onCustomerSelected(_ sender: Any) {
        APIManager.setType(type: "customer") { json in
            self.onResult(json: json)
        }
    }
    @IBAction func onDesignerSelected(_ sender: Any) {
        APIManager.setType(type: "designer") { json in
            self.onResult(json: json)
        }
    }
    func onResult(json:JSON) {
        if json["success"].boolValue {
            Globals.type = json["type"].stringValue
            moveToNext()
        }
        else {
            Globals.alert(context: self, title: "Set Type", message: json["message"].stringValue)
        }
    }
    func moveToNext(){
        let customer = storyboard!.instantiateViewController(withIdentifier: "\(Globals.type)_home")
        customer.modalPresentationStyle = .fullScreen
        present(customer, animated: true, completion: nil)
    }
}

