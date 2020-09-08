//
//  DesignerMyFoldersViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/19/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON
import JGProgressHUD

class DesignerMyFoldersViewController: BaseViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var folders = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Globals.type = "designer"
        type = "designer"
        pathView.setPath(path: ["My folders"])
    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    func getData(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        APIManager.getFolders { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.folders = json["res"].arrayValue
                self.refreshView()
            }
            else {
//                Globals.alert(context: self, title: "Folders", message: json["message"].stringValue)
                self.view.makeToast(json["message"].stringValue)
            }
        }
    }
    func refreshView() {
        if(folders.count == 0) {
            emptyView.isHidden = false
            collectionView.isHidden = true
        }
        else {
            emptyView.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
    
    @IBAction func onCreateNewFolder(_ sender: Any) {
        openDialog(id: "create_folder_designer") {
            self.getData()
        }
    }
}

extension DesignerMyFoldersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return folders.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderCell", for: indexPath as IndexPath)
        
        let name = cell.viewWithTag(100) as! UILabel
        name.text = folders[indexPath.row]["name"].stringValue
        
        let description = cell.viewWithTag(101) as! UILabel
        description.text = folders[indexPath.row]["description"].stringValue
        
        let itemCount = cell.viewWithTag(102) as! UILabel
        itemCount.text = "\(folders[indexPath.row]["items"].arrayValue.count) items"
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Globals.folderID = folders[indexPath.row]["_id"].stringValue
        navigateTo(id: "techpack_designer", pathId: folders[indexPath.row]["name"].stringValue)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth:CGFloat = (view.bounds.width-96)/3.0
        let yourHeight:CGFloat = 190
        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 24, bottom: 0, right: 24)
    }
}
