//
//  DesignerMyFoldersViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/19/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class DesignerMyFoldersViewController: DefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        type = "designer"
        pathView.setPath(path: ["My folders"])
    }
    
    override func onProfileClicked() {
        openDialog(id: "complete_profile_designer")
    }
    
    @IBAction func onCreateNewFolder(_ sender: Any) {
        openDialog(id: "create_folder_designer")
    }
}

