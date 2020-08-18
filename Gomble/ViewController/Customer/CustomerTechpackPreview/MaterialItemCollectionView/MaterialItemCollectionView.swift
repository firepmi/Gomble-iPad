//
//  MaterialItemCollectionView.swift
//  TV Escola Adult
//
//  Created by Mobile World on 2/14/19.
//  Copyright © 2019 Jenya Ivanova. All rights reserved.
//

import UIKit
//import SwiftyJSON

//protocol MaterialItemCollectionViewDelegate {
//    func MaterialItemCollectionView(_ MaterialItemCollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, section: Int)
//    func MaterialItemCollectionView(_ MaterialItemCollectionView: UICollectionView, loadMoreSectionAt: Int)
//}
class MaterialItemCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    var itemDelegate: MaterialItemCollectionViewDelegate!
    var selected = -1
    var identifier = "materialItemCell"
    var categoryMaterialList:[String] = []
    var collectionPosition = CGFloat(0)
    var section = 0
    var waiting = false
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: bounds, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = true
        cv.delegate = self
        cv.dataSource = self
        cv.register(UINib(nibName: "MaterialItemCell", bundle: nil), forCellWithReuseIdentifier: identifier)
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
        addSubview(collectionView)
    }
//    public func setDelegate(itemCollectionDelegate: MaterialItemCollectionViewDelegate) {
////        itemDelegate = itemCollectionDelegate
//        addSubview(collectionView)
//    }
    public func setScrollDirection(direction: UICollectionView.ScrollDirection){
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.scrollDirection = direction
    }
    public func setContentOffset(offset:CGFloat){
        collectionPosition = offset
        collectionView.contentOffset.x = collectionPosition
    }
    
    public func reloadData(array:[String], selectedIndex: Int, scrollingPosition:CGFloat, rowSection: Int){
        categoryMaterialList = array
        selected = selectedIndex
        section = rowSection
        collectionPosition = scrollingPosition
        waiting = false
        collectionView.reloadData()
    }
    public func reloadData(array:[String], scrollingPosition:CGFloat){
        categoryMaterialList = array
        collectionPosition = scrollingPosition
        waiting = false
        collectionView.reloadData()
    }
    public func reloadData(array:[String]){
        categoryMaterialList = array
        waiting = false
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryMaterialList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath as IndexPath)
        
        if categoryMaterialList.count <= indexPath.row {
            return cell
        }
        let listData = categoryMaterialList[indexPath.row]
        
        let titleLabel:UILabel = cell.viewWithTag(102) as! UILabel
        titleLabel.text = listData
               
        
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 1
        cell.contentView.layer.shadowOffset = CGSize(width: -1, height: 1)
        cell.contentView.layer.shadowRadius = 4.0
        
        return cell;
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("collectionview scroll end")
        collectionPosition = scrollView.contentOffset.x
    }
    
    func reloadCell(y:Int){
        if y < 0 {
            return ;
        }
        selected = -1;
        let indexPath1 = IndexPath(row: y, section: 0)
        collectionView.reloadItems(at: [indexPath1])
    }    
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 124, height: 305)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 25)
    }
}
