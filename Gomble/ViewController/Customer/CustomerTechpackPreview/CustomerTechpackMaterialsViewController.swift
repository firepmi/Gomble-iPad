//
//  CustomerTechpackMaterialDetailsViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/18/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class CustomerTechpackMaterialDetailsViewController: UIViewController, IndicatorInfoProvider  {
    var itemInfo: IndicatorInfo = "Materials/Accesories"
    
    let mData = ["Sleeve","Top","Bottom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

extension CustomerTechpackMaterialDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "materialCell";
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID as String)!
        cell.selectionStyle = .none
        
        let titleLabel = cell.viewWithTag(100) as! UILabel
        titleLabel.text = mData[indexPath.row]
        
        let mItemCell = cell.viewWithTag(101) as! MaterialItemCollectionView
        let testData = ["Fabric_01","Fabric_01","Fabric_01"]
        mItemCell.reloadData(array: testData, scrollingPosition: 0)
                
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 305
    }
}
