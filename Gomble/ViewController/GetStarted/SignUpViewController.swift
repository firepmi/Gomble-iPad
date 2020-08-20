//
//  SignUpViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/13/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SignUpViewController: UIViewController, IndicatorInfoProvider {
    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var passwordTextField: RoundedTextField!
    @IBOutlet weak var confirmTextField: RoundedTextField!
    
    var itemInfo: IndicatorInfo = "Sign Up"
    var isChecked = false
    
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
    @IBAction func onCheckboxClicked(_ sender: Any) {
        isChecked = !isChecked
        if(isChecked) {
            checkboxImageView.image = UIImage(named: "icon_check_on.png")
        }
        else {
            checkboxImageView.image = UIImage(named: "icon_check_off.png")
        }
    }
    @IBAction func onClickedTermsOfService(_ sender: Any) {
        print("terms of service")
    }
    @IBAction func onCreateAccount(_ sender: Any) {
//        performSegue(withIdentifier: "toSelectType", sender: nil) //TODO; remove after tested
        if(!isChecked) {
            Globals.alert(context: self, title: "Sign Up", message: "You should agree to the terms of service to create an account", delayed: false)
        }
        else if(emailTextField.text == "" || passwordTextField.text == "" || confirmTextField.text == "") {
            Globals.alert(context: self, title: "Sign Up", message: "Please fill out all required fields", delayed: false)
        }
        else if(passwordTextField.text!.count < 6) {
            Globals.alert(context: self, title: "Sign Up", message: "Password required at least 6 letters", delayed: false)
        }
        else if(passwordTextField.text != confirmTextField.text) {
            Globals.alert(context: self, title: "Sign Up", message: "Password does not match", delayed: false)
        }
        else {
            performSegue(withIdentifier: "toSelectType", sender: nil)
        }
    }
}
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            confirmTextField.becomeFirstResponder()
        }
        else if textField == confirmTextField {
            dismissKeyboard()
        }
        return true
    }
  
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
