//
//  DesignerMyFoldersViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/19/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class DesignerMyFoldersViewController: BaseViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Globals.type = "designer"
        type = "designer"
        pathView.setPath(path: ["My folders"])
    }
    override func viewDidAppear(_ animated: Bool) {
        refreshView()
    }
    func refreshView() {
        if(Testdatabase.folders.count == 0) {
            emptyView.isHidden = false
            collectionView.isHidden = true
        }
        else {
            emptyView.isHidden = true
            collectionView.isHidden = false
        }
    }
    
    @IBAction func onCreateNewFolder(_ sender: Any) {
        openDialog(id: "create_folder_designer") {
            self.collectionView.reloadData()
            self.refreshView()
        }
    }
}

extension DesignerMyFoldersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Testdatabase.folders.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderCell", for: indexPath as IndexPath)
        
        let name = cell.viewWithTag(100) as! UILabel
        name.text = Testdatabase.folders[indexPath.row]["name"].stringValue
        
        let description = cell.viewWithTag(101) as! UILabel
        description.text = Testdatabase.folders[indexPath.row]["description"].stringValue
        
        let itemCount = cell.viewWithTag(102) as! UILabel
        itemCount.text = "\(Testdatabase.folders[indexPath.row]["items"].arrayValue.count) items"
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateTo(id: "techpack_designer", pathId: Testdatabase.folders[indexPath.row]["name"].stringValue)
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
