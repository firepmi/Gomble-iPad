//
//  NewTechpackDesignerViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/20/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class NewTechpackDesignerViewController: DefaultViewController {

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        type = "designer"
    }
    override func viewDidAppear(_ animated: Bool) {
        refreshView()
    }
    func refreshView() {
        if(Testdatabase.techpacks.count == 0) {
            emptyView.isHidden = false
            collectionView.isHidden = true
        }
        else {
            emptyView.isHidden = true
            collectionView.isHidden = false
        }
    }
     
    @IBAction func onCreateTechpack(_ sender: Any) {
        openDialog(id: "create_folder_designer") {
            self.collectionView.reloadData()
            self.refreshView()
        }
    }
}

extension NewTechpackDesignerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Testdatabase.techpacks.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderCell", for: indexPath as IndexPath)
        
        let name = cell.viewWithTag(100) as! UILabel
        name.text = Testdatabase.techpacks[indexPath.row]["name"].stringValue
        
        let description = cell.viewWithTag(101) as! UILabel
        description.text = Testdatabase.techpacks[indexPath.row]["description"].stringValue
        
        let itemCount = cell.viewWithTag(102) as! UILabel
        itemCount.text = "\(Testdatabase.techpacks[indexPath.row]["items"].arrayValue.count) items"
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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

