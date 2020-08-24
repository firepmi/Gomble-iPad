//
//  SignInViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/12/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

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
        let customer = storyboard!.instantiateViewController(withIdentifier: "designer_home")
        customer.modalPresentationStyle = .fullScreen
        present(customer, animated: true, completion: nil)
        if(emailTextField.text == "" || passwordTextField.text == "") {
            Globals.alert(context: self, title: "Sign In", message: "Please fill out all required fields", delayed: false)
            return
        }
        if(passwordTextField.text!.count < 6) {
            Globals.alert(context: self, title: "Sign In", message: "Password required at least 6 letters", delayed: false)
            return
        }
        
//        let customer = storyboard!.instantiateViewController(withIdentifier: "select_type")
//        customer.modalPresentationStyle = .fullScreen
//        present(customer, animated: true, completion: nil)
        
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

