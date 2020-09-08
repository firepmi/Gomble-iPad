//
//  DesignerTechpacksViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/20/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import JGProgressHUD
import SwiftyJSON

class DesignerTechpacksViewController: BaseViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var techpacks = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        type = "designer"
        titleLabel.text = PathView.pathData.last
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
        APIManager.getTechpacks(param: param) { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.techpacks = json["res"].arrayValue
                self.refreshView()
            }
            else {
                self.view.makeToast(json["message"].stringValue)
            }
        }
    }
    func refreshView() {
        if(techpacks.count == 0) {
            emptyView.isHidden = false
            collectionView.isHidden = true
        }
        else {
            emptyView.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
     
    @IBAction func onCreateTechpack(_ sender: Any) {
        navigateTo(id: "new_techpack_designer", pathId: "New techpack")
    }
}

extension DesignerTechpacksViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return techpacks.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "techpackCell", for: indexPath as IndexPath)

        let imageName:String = techpacks[indexPath.row]["image"].stringValue
        
        let image = cell.viewWithTag(100) as! UIImageView
        image.image = UIImage(named: imageName)//techPackData[indexPath.row]["title"]!)
        
        let title = cell.viewWithTag(101) as! UILabel
        title.text = techpacks[indexPath.row]["title"].stringValue
        
        let massView = cell.viewWithTag(104)!
        massView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
        massView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateTo(id: "preview_customer")
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

