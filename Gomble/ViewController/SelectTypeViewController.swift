//
//  SelectTypeViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/13/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class SelectTypeViewController: UIViewController {

    @IBOutlet weak var customerView: UIView!
    @IBOutlet weak var designerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customerView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
        designerView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
    }

    @IBAction func onCustomerSelected(_ sender: Any) {
    }
    @IBAction func onDesignerSelected(_ sender: Any) {
    }
}

