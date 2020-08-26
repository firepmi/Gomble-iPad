//
//  CircleColorListView.swift
//  Gomble
//
//  Created by mobileworld on 8/24/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
@IBDesignable
class CircleColorListView: UIView {
    var identifier = "pathViewCell"
    @IBInspectable var radius: CGFloat = 8 {
        didSet {
            collectionView.reloadData()
        }
    }
    var colorList:[UIColor] = [.white, .black, .green]
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: bounds, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(UINib(nibName: "PathViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        cv.backgroundColor = UIColor.clear
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.clear
        let flowLayout = cv.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = .horizontal
        
        return cv
    }()
        
    override var bounds: CGRect {
        didSet {
            collectionView.frame = bounds
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)        
    }
}
extension CircleColorListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath)
        
        let circleView = cell.viewWithTag(100) as! RoundedView
        circleView.cornerRadius = radius
        circleView.backgroundColor = colorList[indexPath.row]
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: radius * 2, height: radius * 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: radius/2, bottom: 0, right: radius/2)
    }
}

