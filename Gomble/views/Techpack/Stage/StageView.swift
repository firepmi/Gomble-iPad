//
//  StageView.swift
//  Gomble
//
//  Created by mobileworld on 8/21/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
@IBDesignable
class StageView: BaseView {
    var selectedColor = UIColor.init(hexString:"#4B62FF")
    
    @IBOutlet weak var ideaView: RoundedView!
    @IBOutlet weak var sampleView: RoundedView!
    @IBOutlet weak var massView: RoundedView!
    @IBOutlet weak var readyToWearView: RoundedView!
    
    @IBOutlet weak var iconRadio1: UIImageView!
    @IBOutlet weak var iconRadio2: UIImageView!
    @IBOutlet weak var iconRadio3: UIImageView!
    @IBOutlet weak var iconRadio4: UIImageView!
    
    override func setNibName() {
        nibName = "StageView"
    }
        
    @IBAction func onCardSelected(_ sender: UIButton) {
        ideaView.borderColor = .clear
        sampleView.borderColor = .clear
        massView.borderColor = .clear
        readyToWearView.borderColor = .clear
        switch sender.tag {
        case 100:
            ideaView.borderColor = selectedColor
            iconRadio1.image = UIImage(named: "icon_radio_on_grey.png")
            iconRadio2.image = UIImage(named: "icon_radio_off_grey.png")
            iconRadio3.image = UIImage(named: "icon_radio_off_grey.png")
            iconRadio4.image = UIImage(named: "icon_radio_off_grey.png")
        case 101:
            sampleView.borderColor = selectedColor
            iconRadio2.image = UIImage(named: "icon_radio_on_grey.png")
            iconRadio1.image = UIImage(named: "icon_radio_off_grey.png")
            iconRadio3.image = UIImage(named: "icon_radio_off_grey.png")
            iconRadio4.image = UIImage(named: "icon_radio_off_grey.png")
        case 102:
            massView.borderColor = selectedColor
            iconRadio3.image = UIImage(named: "icon_radio_on_grey.png")
            iconRadio1.image = UIImage(named: "icon_radio_off_grey.png")
            iconRadio2.image = UIImage(named: "icon_radio_off_grey.png")
            iconRadio4.image = UIImage(named: "icon_radio_off_grey.png")
        case 103:
            readyToWearView.borderColor = selectedColor
            iconRadio4.image = UIImage(named: "icon_radio_on_grey.png")
            iconRadio1.image = UIImage(named: "icon_radio_off_grey.png")
            iconRadio2.image = UIImage(named: "icon_radio_off_grey.png")
            iconRadio3.image = UIImage(named: "icon_radio_off_grey.png")
        default:
            break
        }
        
    }
    
}
