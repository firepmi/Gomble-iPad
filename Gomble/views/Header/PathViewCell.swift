//
//  PathViewCell.swift
//  Gomble
//
//  Created by mobileworld on 8/16/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class PathViewCell: UICollectionViewCell {
        
    @IBOutlet weak var pathLabel: UILabel!
    var pathTitle: String? {
        get {
            return pathLabel.text
        }
        set {
            pathLabel.text = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

