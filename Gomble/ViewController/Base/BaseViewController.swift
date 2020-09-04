//
//  BaseViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/16/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {
    @IBOutlet weak var customHeaderView: CustomHeaderView!
    @IBOutlet weak var pathView: PathView!
    var type = Globals.type
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
    func openDialog(id:String, completion: (()->Void)? = nil) {
        let vc = storyboard!.instantiateViewController(withIdentifier: id) as! BaseDialogViewController
                
        vc.modalPresentationStyle = .overFullScreen
        vc.completion = completion
        let popover = vc.popoverPresentationController
        popover?.sourceView = self.view
        popover?.sourceRect = self.view.bounds
        popover?.delegate = self as? UIPopoverPresentationControllerDelegate
        vc.modalTransitionStyle = .crossDissolve
        
        self.present(vc, animated: true, completion:nil)
    }
    func navigateTo(id:String, pathId:String = "") {
        if pathId == "" {
            PathView.pathData.append(id)
        }
        else {
            PathView.pathData.append(pathId)
        }
        let preview = storyboard!.instantiateViewController(withIdentifier: id)
        navigationController?.pushViewController(preview, animated: true)
    }
    func onNotificationClicked(){
        print("notification")
    }
    func onProfileClicked(){
        navigateTo(id: "profile", pathId: "Profile")
//        if type == "designer" {
//            openDialog(id: "complete_profile_designer")
//        }
//        else {
//            navigateTo(id: "profile")
//        }
    }
    func onSettingsClicked(){
        print("settings")
    }
    @IBAction func onBackButton(_ sender: Any) {
        onBack()
    }
    func onBack(){
        navigationController?.popViewController(animated: true)
        let result = PathView.pathData.popLast()
        print(String(describing: result))
    }
}

extension BaseViewController: CustomHeaderViewDelegate {
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
extension BaseViewController: PathViewDelegate {
    func pathView(_ pathView: PathView, clicked index: Int) {
        print("selected path \(index)")
    }
}
