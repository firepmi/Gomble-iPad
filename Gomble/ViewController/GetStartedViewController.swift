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
    
    let labelColor = UIColor.white
       
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = labelColor
        settings.style.buttonBarItemFont = UIFont(name: "Gilroy-ExtraBold", size: 20)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
//            oldCell?.label.textColor = self?.labelColor
//            oldCell?.label.font = UIFont(name: "Gilroy-ExtraBold", size: 20)!
//            newCell?.label.textColor = .black
//            newCell?.label.font = UIFont(name: "Gilroy-ExtraBold", size: 20)!
//            newCell?.backgroundView?.backgroundColor = UIColor.clear
        }
        super.viewDidLoad()
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
    }
    // MARK: - PagerTabStripDataSource

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let signin = storyboard!.instantiateViewController(withIdentifier: "signin")
        let signup = storyboard!.instantiateViewController(withIdentifier: "signup")
        return [signin, signup]
    }
}

