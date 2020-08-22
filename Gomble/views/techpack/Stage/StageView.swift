//
//  StageView.swift
//  Gomble
//
//  Created by mobileworld on 8/21/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
@IBDesignable
class StageView: UIView {
    let nibName = "StageView"

    var contentView:UIView?
    var selectedColor = UIColor.init(hexString:"#4B62FF")
    
    @IBOutlet weak var ideaView: RoundedView!
    @IBOutlet weak var sampleView: RoundedView!
    @IBOutlet weak var massView: RoundedView!
    @IBOutlet weak var readyToWearView: RoundedView!
    
    @IBOutlet weak var iconRadio1: UIImageView!
    @IBOutlet weak var iconRadio2: UIImageView!
    @IBOutlet weak var iconRadio3: UIImageView!
    @IBOutlet weak var iconRadio4: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit(){
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        contentView = view
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: CustomHeaderView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        contentView?.prepareForInterfaceBuilder()
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
