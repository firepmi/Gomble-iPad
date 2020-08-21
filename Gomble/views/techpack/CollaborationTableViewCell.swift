//
//  CollaborationTableViewCell.swift
//  Gomble
//
//  Created by mobileworld on 8/21/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class CollaborationTableViewCell: UITableViewCell {
       
    @IBOutlet weak var profileIndicatorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var invitedLabel: UILabel!
    @IBOutlet weak var inviteIconImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
