//
//  CreateFolderDesignerViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/19/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

class CreateFolderDesignerViewController: DefaultDialogViewController {

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
        var json = JSON()
        json["name"].string = folderNameLabel.text!
        json["description"].string = descriptionTextView.text
        Testdatabase.folders.append(json)
        if (completion != nil) {
            completion!()
        }
        dismiss(animated: true, completion: nil)
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
