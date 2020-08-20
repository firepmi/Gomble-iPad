//
//  DefaultViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/16/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SideMenu

class DefaultViewController: UIViewController {
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var pathView: CustomerPathView!
    var type = "customer"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        customHeaderView.delegate = self
        pathView.delegate = self
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func onMenuClicked(){
        var sideMenuId = "customeSideMenu"
        if type == "designer" {
            sideMenuId = "designerSideMenu"
        }
        let sideMenu = storyboard!.instantiateViewController(withIdentifier: sideMenuId) as! SideMenuNavigationController
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.presentationStyle.onTopShadowColor = .blue
        settings.presentationStyle.onTopShadowRadius = 100
        settings.statusBarEndAlpha = 0
        settings.presentationStyle.menuOnTop = true
        sideMenu.settings = settings
        present(sideMenu, animated: true, completion: nil)
    }
    func openDialog(id:String){
        let vc = storyboard!.instantiateViewController(withIdentifier: id)
                
        vc.modalPresentationStyle = .overFullScreen
//        vc.dialogDelegate = self
        let popover = vc.popoverPresentationController
        popover?.sourceView = self.view
        popover?.sourceRect = self.view.bounds
        popover?.delegate = self as? UIPopoverPresentationControllerDelegate
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion:nil)
    }
    func onNotificationClicked(){
        print("notification")
    }
    func onProfileClicked(){
        let profile = storyboard!.instantiateViewController(withIdentifier: "profile_customer")
        navigationController?.pushViewController(profile, animated: true)
    }
    func onSettingsClicked(){
        print("settings")
    }
    @IBAction func onBackButton(_ sender: Any) {
        onBack()
    }
    func onBack(){
        navigationController?.popViewController(animated: true)
    }
}

extension DefaultViewController: CustomHeaderViewDelegate {
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
extension DefaultViewController: CustomerPathViewDelegate {
    func customerPathView(_ customerPathView: CustomerPathView, clicked index: Int) {
        print("selected path \(index)")
    }
}
