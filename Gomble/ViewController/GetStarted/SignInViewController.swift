//
//  SignInViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/12/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SwiftyJSON
import Toast_Swift
import JGProgressHUD

class SignInViewController: UIViewController, IndicatorInfoProvider {
    var itemInfo: IndicatorInfo = "Sign In"
    
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        passwordTextField.textContentType = .oneTimeCode
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    @IBAction func onLogin(_ sender: Any) {
        //TODO: remove after tested
//        let customer = storyboard!.instantiateViewController(withIdentifier: "designer_home")
//        customer.modalPresentationStyle = .fullScreen
//        present(customer, animated: true, completion: nil)
        if(emailTextField.text == "" || passwordTextField.text == "") {
            Globals.alert(context: self, title: "Sign In", message: "Please fill out all required fields")
            return
        }
        if(passwordTextField.text!.count < 6) {
            Globals.alert(context: self, title: "Sign In", message: "Password required at least 6 letters")
            return
        }
        var param = [String:String]()
        param["email"] = emailTextField.text
        param["password"] = passwordTextField.text
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        APIManager.login(param: param) { (json) in
            print(json)
            hud.dismiss()
            if json["success"].boolValue {
                APIManager.token = json["token"].stringValue
                
                var vc_id = "select_type"
                if json["type"].stringValue != "-" {
                    vc_id = json["type"].stringValue + "_home"
                }
                self.goToVC(id: vc_id)
            }
            else {
//                self.view.makeToast(json["message"].stringValue)
                Globals.alert(context: self, title: "Sign In", message: json["message"].stringValue)
            }
        }
        
    }
    func goToVC(id:String) {
        let customer = storyboard!.instantiateViewController(withIdentifier: id)
        customer.modalPresentationStyle = .fullScreen
        present(customer, animated: true, completion: nil)
    }
    @IBAction func onForgotPassword(_ sender: Any) {
    }
    
}
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            dismissKeyboard()
        }
        return true
    }
  
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

