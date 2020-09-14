//
//  CircleColorListView.swift
//  Gomble
//
//  Created by mobileworld on 8/24/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class CircleColorListView: BaseView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var identifier = "CircleColorCell"
    @IBInspectable var radius: CGFloat = 8 {
        didSet {
            collectionView.reloadData()
        }
    }
    var colorList:[JSON] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView!.collectionViewLayout.invalidateLayout()
                self.collectionView!.layoutSubviews()
            }
        }
    }
        
    override func setNibName() {
        nibName = "CircleColorListView"
    }
    override func initView() {
        collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
}
extension CircleColorListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath) as! CircleColorCell
        
        cell.circleView.cornerRadius = radius
        let colorCode = "#\(colorList[indexPath.row]["code"].stringValue)"
        cell.circleView.backgroundColor = UIColor(hexString: colorCode)
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: radius * 2, height: radius * 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: radius/2, bottom: 0, right: radius/2)
    }
}

