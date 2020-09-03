//
//  PathView.swift
//  Gomble
//
//  Created by mobileworld on 8/16/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
@IBDesignable
class PathView: BaseView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate:PathViewDelegate!
    public static var pathData = [String]()
        
    override func setNibName() {
        nibName = "PathView"
    }
    
    override func initView() {
        collectionView.register(UINib(nibName: "PathViewCell", bundle: nil), forCellWithReuseIdentifier: "PathViewCell")
    }
    
    func setPath(path:[String]) {
        PathView.pathData = path
        collectionView.reloadData()
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PathView.pathData.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PathViewCell", for: indexPath as IndexPath) as! PathViewCell

        cell.pathTitle = PathView.pathData[indexPath.row]
        if indexPath.row == PathView.pathData.count - 1 {
            cell.pathLabel.textColor = UIColor.init(hexString: "#004de0")
        }
        else {
            cell.pathLabel.textColor = UIColor.init(hexString: "#4c91ff")
        }
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.pathView(self, clicked: indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PathViewCell", for: indexPath as IndexPath) as! PathViewCell

        cell.pathLabel.text = PathView.pathData[indexPath.row]
        let width = cell.pathLabel.intrinsicContentSize.width + 35
        if( width > 96 ) {
            return CGSize(width: width,height: 25)
        }
        else {
            return CGSize(width: 96,height: 25)
        }
        
    }
}

protocol PathViewDelegate {
    func pathView(_ pathView: PathView, clicked index:Int)
}

