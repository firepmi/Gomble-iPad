//
//  SignUpViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/13/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SignUpViewController: UIViewController, IndicatorInfoProvider {
    var itemInfo: IndicatorInfo = "Sign Up"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
