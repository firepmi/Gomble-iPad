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
    @IBOutlet weak var pathView: CustomerPathView!
    
    let techPackData = [
        ["title":"Summer dress collection", "image":"test1.png"],
        ["title":"Elegant gray dress", "image":"test2.png"],
        ["title":"Coral cotton dress", "image":"test3.png"],
        ["title":"Summer dress collection with dot", "image":"test4.png"],
        ["title":"Summer dress collection with flowers", "image":"test5.png"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        customHeaderView.delegate = self
        pathView.setPath(path: ["Products"])
        pathView.delegate = self
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
        let profile = storyboard!.instantiateViewController(withIdentifier: "profile_customer")
        navigationController?.pushViewController(profile, animated: true)
    }
    func onSettingsClicked(){
        print("settings")
    }
}
extension CustomerHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return techPackData.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "techpackCell", for: indexPath as IndexPath)

        let imageName:String = techPackData[indexPath.row]["image"]!
        
        let image = cell.viewWithTag(100) as! UIImageView
        image.image = UIImage(named: imageName)//techPackData[indexPath.row]["title"]!)
        
        let title = cell.viewWithTag(101) as! UILabel
        title.text = techPackData[indexPath.row]["title"]
        
        let massView = cell.viewWithTag(104)!
        massView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
        massView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("item clicked")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 224, height: 329)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let numberofCell = view.frame.size.width / 224
        let edgeInsets = (view.frame.size.width - (numberofCell * 224)) / (numberofCell + 1)
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
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
extension CustomerHomeViewController: CustomerPathViewDelegate {
    func customerPathView(_ customerPathView: CustomerPathView, clicked index: Int) {
        print("selected path \(index)")
    }
}
