//
//  SuccessAddedTechpackViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/28/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

class SuccessAddedTechpackViewController: BaseDialogViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func onPreview(_ sender: Any) {
        dismiss(animated: true, completion: completion)
    }
    @IBAction override func onClose(_ sender: Any) {
        dismiss(animated: true, completion: completion)
    }
}
