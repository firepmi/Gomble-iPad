//
//  CustomerTechpackPreviewDetailsViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/18/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CustomerTechpackPreviewDetailsViewController: ButtonBarPagerTabStripViewController {
    let selectedColor = UIColor.init(hexString: "#436EFF")
    let unselectedColor = UIColor.init(hexString:"#8b94a6")
    override func viewDidLoad() {
        
        // Do any additional setup after loading the view.
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = selectedColor
        settings.style.buttonBarItemFont = UIFont(name: "Gilroy-ExtraBold", size: 16)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = selectedColor
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self?.unselectedColor
            oldCell?.label.font = UIFont(name: "Gilroy-ExtraBold", size: 16)!
            newCell?.label.textColor = self?.selectedColor
            newCell?.label.font = UIFont(name: "Gilroy-ExtraBold", size: 16)!
            newCell?.backgroundView?.backgroundColor = UIColor.clear
        }
        super.viewDidLoad()
    }
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let generalInfo = storyboard!.instantiateViewController(withIdentifier: "generalInfo")
        let materialsAccesories = storyboard!.instantiateViewController(withIdentifier: "materialsAccesories")
        let options = storyboard!.instantiateViewController(withIdentifier: "options")
        let measurements = storyboard!.instantiateViewController(withIdentifier: "measurements")
        let aboutDesigner = storyboard!.instantiateViewController(withIdentifier: "aboutDesigner")
        return [generalInfo, materialsAccesories, options, measurements, aboutDesigner]
    }
}


