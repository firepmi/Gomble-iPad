//
//  CircleColorCell.swift
//  Gomble
//
//  Created by mobileworld on 9/14/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class CircleColorCell: UICollectionViewCell {
     
    @IBOutlet weak var circleView: RoundedView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

