//
//  CustomerHomeViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/14/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SideMenu
import JGProgressHUD
import SwiftyJSON

class CustomerHomeViewController: BaseViewController {
    var techpacks = [JSON]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        type = "customer"
        Globals.type = "customer"
        pathView.setPath(path: ["Products"])
    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    func getData(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        var param = [String:String]()
        param["folder_id"] = Globals.folderID
        APIManager.getProducts(param: param) { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.techpacks = json["res"].arrayValue
                self.collectionView.reloadData()
//                self.refreshView()
            }
            else {
                self.view.makeToast(json["message"].stringValue)
            }
        }
    }
}
extension CustomerHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return techpacks.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "techpackCell", for: indexPath as IndexPath)

        let imageUrl = APIManager.fullGeneralInfoImagePath(name: techpacks[indexPath.row]["image"].stringValue)
        let image = cell.viewWithTag(100) as! UIImageView
        image.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "test1.png"))
        
        let title = cell.viewWithTag(101) as! UILabel
        title.text = techpacks[indexPath.row]["title"].stringValue
        
        let tagLabel = cell.viewWithTag(102) as! UILabel
        var tagStr = ""
        for tag in techpacks[indexPath.row]["tags"].arrayValue {
            tagStr += tag.stringValue + ","
        }
        if tagStr.count != 0 {
            tagStr = tagStr[0..<tagStr.count-1]
        }
        tagLabel.text = tagStr
        
        let price = cell.viewWithTag(103) as! UILabel
        price.text = techpacks[indexPath.row]["price_total"].floatValue.currencyFormattedStr()
        
        let massView = cell.viewWithTag(104)!
        massView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
        massView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Globals.techpackID = techpacks[indexPath.row]["_id"].stringValue
        navigateTo(id: "preview_customer",pathId: techpacks[indexPath.row]["title"].stringValue)
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

