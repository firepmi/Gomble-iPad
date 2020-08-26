//
//  MaterialColorCell.swift
//  Gomble
//
//  Created by mobileworld on 8/25/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class MaterialColorCell: UITableViewCell {
    
    @IBOutlet weak var colorView: RoundedView!
    @IBOutlet weak var descriptionTextField: RoundedTextField!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


