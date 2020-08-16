//
//  CustomHeaderView.swift
//  Gomble
//
//  Created by mobileworld on 8/14/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
@IBDesignable
class CustomHeaderView: UIView {
    let nibName = "CustomHeaderView"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: RoundedImageView!
    var contentView:UIView?
    var delegate:CustomHeaderViewDelegate!
    
    @IBInspectable var title: String = "Gomble" {
        didSet {
            titleLabel?.text = title
        }
    }
    
    @IBInspectable var profileImage: UIImage =  UIImage(named: "profile-anonymous.jpg")! {
        didSet {
            profileImageView?.image = profileImage
        }
    }
    override class func awakeFromNib() {
        super.awakeFromNib()
//        commonInit(self)
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
        titleLabel.text = title
        profileImageView.image = profileImage
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        contentView?.prepareForInterfaceBuilder()
    }
    @IBAction func onMenuClicked(_ sender: Any) {
        delegate.customHeaderView(self, clicked: 0)
    }
    @IBAction func onNotificatoinClicked(_ sender: Any) {
        delegate.customHeaderView(self, clicked: 1)
    }
    @IBAction func onSettingClicked(_ sender: Any) {
        delegate.customHeaderView(self, clicked: 2)
    }
    @IBAction func onProfileClicked(_ sender: Any) {
        delegate.customHeaderView(self, clicked: 3)
    }
    
}

protocol CustomHeaderViewDelegate {
    func customHeaderView(_ customerHeaderView: CustomHeaderView, clicked index:Int)
}
