//
//  CreateFolderDesignerViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/19/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON
import JGProgressHUD

class CreateFolderDesignerViewController: BaseDialogViewController {

    @IBOutlet weak var folderNameLabel: RoundedTextField!
    @IBOutlet weak var descriptionTextView: RoundedTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        folderNameLabel.delegate = self
    }
    
    @IBAction func onCreateFolder(_ sender: Any) {
        if folderNameLabel.text == "" {
            folderNameLabel.borderColor = UIColor.red
            return
        }
        else {
            folderNameLabel.borderColor = UIColor.init(hexString:"#D7E1EC")
        }
        var param = [String:String]()
        param["name"] = folderNameLabel.text!
        param["description"] = descriptionTextView.text
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        APIManager.createFolder(param: param) { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.completion?()
                self.dismiss(animated: true, completion: nil)
            }
            else {
                Globals.alert(context: self, title: "Folders", message: json["message"].stringValue)
            }
        }
    }
}
extension CreateFolderDesignerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == folderNameLabel {
            descriptionTextView.becomeFirstResponder()
        }
        else {
            dismissKeyboard()
        }
        return true
    }
  
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
