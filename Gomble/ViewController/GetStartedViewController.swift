//
//  GetStartedViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/11/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class GetStartedViewController: ButtonBarPagerTabStripViewController {
    
    let labelColor = UIColor(hexString: "#5f6772")
       
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = labelColor
        settings.style.buttonBarItemFont = UIFont(name: "DMSans-Bold", size: 16)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self?.labelColor
            oldCell?.label.font = UIFont(name: "DMSans-Regular", size: 16)!
            newCell?.label.textColor = .black
            newCell?.label.font = UIFont(name: "DMSans-Bold", size: 16)!
        }
        super.viewDidLoad()
        
    }
    // MARK: - PagerTabStripDataSource

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let signin = storyboard!.instantiateViewController(withIdentifier: "signin")
        let signup = storyboard!.instantiateViewController(withIdentifier: "signup")
        return [signin, signup]
    }
}

