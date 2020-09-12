//
//  StageTableViewCell.swift
//  Gomble
//
//  Created by mobileworld on 9/10/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import DatePickerDialog

class StageTableViewCell: UITableViewCell {
        
    @IBOutlet weak var containerView: RoundedView!
    @IBOutlet weak var iconRadioImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var completionLabel: UILabel!
    @IBOutlet weak var completionSlider: UISlider!   
    
    var completion : Float = 50 {
        didSet {
            completionLabel.text = "\(Int(completion))%"
            completionSlider.value = completion
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func onPickStartDate(_ sender: Any) {
        DatePickerDialog().show("Start date", doneButtonTitle: "Select", cancelButtonTitle: "Cancel", datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yy"
                self.startDateLabel.text = formatter.string(from: dt)
            }
        }
    }
    @IBAction func onPickEndDate(_ sender: Any) {
        DatePickerDialog().show("Delivery date", doneButtonTitle: "Select", cancelButtonTitle: "Cancel", datePickerMode: .date) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yy"
                self.endDateLabel.text = formatter.string(from: dt)
            }
        }
    }
    @IBAction func onSliderChange(_ sender: UISlider) {
        completion = round(sender.value)
    }
    
}


