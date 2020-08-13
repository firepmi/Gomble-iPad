//
//  CreateNewPasswordViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/13/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class CreateNewPasswordViewController: UIViewController {

    @IBOutlet weak var passwordTextField: RoundedTextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        emailLabel.text = email
    }

    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onConfirm(_ sender: Any) {
        if(passwordTextField.text == "") {
            Globals.alert(context: self, title: "Create New Password", message: "Password is empty", delayed: false)
        }
        else if(passwordTextField.text!.count < 6 ) {
            Globals.alert(context: self, title: "Create New Password", message: "Password required at least 6 letters", delayed: false)
        }
        else {
            closeAll()
        }
    }
    func closeAll() {
        let parent = presentingViewController
        dismiss(animated: false) {
            parent?.dismiss(animated: true, completion: nil)
        }
    }
}

extension CreateNewPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            dismissKeyboard()
        }
        return true
    }
  
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

