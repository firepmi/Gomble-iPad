//
//  MeasurementCell.swift
//  Gomble
//
//  Created by mobileworld on 8/26/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class MeasurementCell: UITableViewCell {
    
    @IBOutlet weak var measurementImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


