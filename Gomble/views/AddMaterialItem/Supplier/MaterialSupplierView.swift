//
//  MaterialSupplierView.swift
//  Gomble
//
//  Created by mobileworld on 8/26/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

@IBDesignable
class MaterialSupplierView: BaseView {
    @IBOutlet weak var factoryNameTextField: RoundedTextField!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var phoneTextField: RoundedTextField!
    @IBOutlet weak var informationTextView: RoundedTextView!
    
    override func setNibName() {
        nibName = "MaterialSupplierView"
    }
}

