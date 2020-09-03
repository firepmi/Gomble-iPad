//
//  CompleteDesignerProfileViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/19/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class CompleteDesignerProfileViewController: BaseDialogViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(white: 0, alpha: 0)
    }
    @IBAction func onCamera(_ sender: Any) {
    }
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onNext(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onSkip(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}


