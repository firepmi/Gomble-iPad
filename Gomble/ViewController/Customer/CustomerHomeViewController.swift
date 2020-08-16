//
//  CustomerHomeViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/14/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SideMenu

class CustomerHomeViewController: UIViewController {

    @IBOutlet weak var customHeaderView: CustomHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        customHeaderView.delegate = self
    }    
    func onMenuClicked(){
        let sideMenu = storyboard!.instantiateViewController(withIdentifier: "customeSideMenu") as! SideMenuNavigationController
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.presentationStyle.onTopShadowColor = .blue
        settings.presentationStyle.onTopShadowRadius = 100
        settings.statusBarEndAlpha = 0
        settings.presentationStyle.menuOnTop = true
        sideMenu.settings = settings
        present(sideMenu, animated: true, completion: nil)
    }
    func onNotificationClicked(){
        print("notification")
    }
    func onProfileClicked(){
        print("profile")
    }
    func onSettingsClicked(){
        print("settings")
    }
}

extension CustomerHomeViewController: CustomHeaderViewDelegate {
    func customHeaderView(_ customerHeaderView: CustomHeaderView, clicked index: Int) {
        switch index {
        case 0: onMenuClicked()
        case 1: onNotificationClicked()
        case 2: onSettingsClicked()
        case 3: onProfileClicked()
        default:
            break
        }
    }
    
    
}
