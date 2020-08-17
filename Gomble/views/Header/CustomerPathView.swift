//
//  CustomerPathView.swift
//  Gomble
//
//  Created by mobileworld on 8/16/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
@IBDesignable
class CustomerPathView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let nibName = "CustomerPathView"
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    var contentView:UIView?
    var delegate:CustomerPathViewDelegate!
    var pathData = [String]()
        
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        pathData = ["Settings","Profile"]
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit(){
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
        contentView = view
        
        collectionView.register(UINib(nibName: "PathViewCell", bundle: nil), forCellWithReuseIdentifier: "PathViewCell")
//        collectionView.delegate = self
//        collectionView.dataSource = self
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: CustomHeaderView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    func setPath(path:[String]) {
        pathData = path
        collectionView.reloadData()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        contentView?.prepareForInterfaceBuilder()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pathData.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PathViewCell", for: indexPath as IndexPath) as! PathViewCell

        cell.pathTitle = pathData[indexPath.row]
        if indexPath.row == pathData.count - 1 {
            cell.pathLabel.textColor = UIColor.init(hexString: "#004de0")
        }
        else {
            cell.pathLabel.textColor = UIColor.init(hexString: "#4c91ff")
        }
        
        return cell;
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.customerPathView(self, clicked: indexPath.row)
    }
}

protocol CustomerPathViewDelegate {
    func customerPathView(_ customerPathView: CustomerPathView, clicked index:Int)
}

