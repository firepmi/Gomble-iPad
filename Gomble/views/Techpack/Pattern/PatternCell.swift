//
//  PatternCell.swift
//  Gomble
//
//  Created by mobileworld on 8/26/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class PatternCell: UITableViewCell {
    
    @IBOutlet weak var patternImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func onEditClicked(_ sender: Any) {
    }
    @IBAction func onDeleteClicked(_ sender: Any) {
    }
}

