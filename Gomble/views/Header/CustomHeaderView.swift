//
//  CustomHeaderView.swift
//  Gomble
//
//  Created by mobileworld on 8/14/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
@IBDesignable
class CustomHeaderView: DefaultView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: RoundedImageView!
    var delegate:CustomHeaderViewDelegate!
    
    @IBInspectable var title: String = "Gomble" {
        didSet {
            titleLabel?.text = title
        }
    }
    
    var profileImage: UIImage =  UIImage(named: "profile-anonymous.jpg") ?? UIImage() {
        didSet {
            profileImageView?.image = profileImage
        }
    }
    
    override func setNibName() {
        nibName = "CustomHeaderView"
    }
    
    override func initView() {
        titleLabel.text = title
        profileImageView.image = profileImage
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
