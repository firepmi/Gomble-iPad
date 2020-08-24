//
//  SketchesTableViewCell.swift
//  Gomble
//
//  Created by mobileworld on 8/24/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class SketchesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sketchimageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var tagView: TagListView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func onEditClicked(_ sender: Any) {
    }
    @IBAction func onDeleteClicked(_ sender: Any) {
    }
}

