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
    
    let labelColor = UIColor(red: 37/255.0, green: 111/255.0, blue: 206/255.0, alpha: 1.0)
       
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = labelColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.labelColor
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

