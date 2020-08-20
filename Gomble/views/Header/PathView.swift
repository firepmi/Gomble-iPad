//
//  PathView.swift
//  Gomble
//
//  Created by mobileworld on 8/16/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
@IBDesignable
class PathView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let nibName = "PathView"
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    var contentView:UIView?
    var delegate:PathViewDelegate!
    public static var pathData = [String]()
        
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
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
        PathView.pathData = path
        collectionView.reloadData()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        contentView?.prepareForInterfaceBuilder()
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

