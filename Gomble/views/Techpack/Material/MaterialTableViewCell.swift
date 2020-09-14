//
//  MaterialTableViewCell.swift
//  Gomble
//
//  Created by mobileworld on 8/24/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class MaterialTableViewCell: UITableViewCell {
    
    @IBOutlet weak var materialImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var placementLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var colorListView: CircleColorListView!
    @IBOutlet weak var factoryNameLabel: UILabel!
    @IBOutlet weak var factoryEmailLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }    
}

