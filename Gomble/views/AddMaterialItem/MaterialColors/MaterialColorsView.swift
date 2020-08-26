//
//  MaterialColorsView.swift
//  Gomble
//
//  Created by mobileworld on 8/25/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON
@IBDesignable
class MaterialColorsView: DefaultView {
    var delegate:UIViewController?
    @IBOutlet weak var tableView: UITableView!
    var colorData:[UIColor] = [.purple, .blue] {
            didSet {
                tableView.reloadData()
//                tableView.layoutIfNeeded()
//                if materialData.count == 0 {
//                    emptyView.isHidden = false
//                    dataView.isHidden = true
//                }
//                else {
//                    emptyView.isHidden = true
//                    dataView.isHidden = false
//                    self.tableViewHeight.constant = 70 * CGFloat(self.materialData.count)
//                    self.tableView.setNeedsUpdateConstraints()
//                    self.tableView.layoutIfNeeded()
//    //                tableView.alwaysBounceVertical = false
//                    viewHeight = CGFloat(tableViewHeight.constant + 120)
//                    if (onHightChanged != nil) {
//                        onHightChanged!(viewHeight)
//                    }
//                }
            }
        }
    var cellID = "MaterialColorCell"
    override func setNibName() {
        nibName = "MaterialColorsView"
    }
    override func initView() {
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
//        colorData = Testdatabase.sketchData
    }
}
extension MaterialColorsView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MaterialColorCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MaterialColorCell
        cell.selectionStyle = .none
        
        let data = colorData[indexPath.row]
        
        cell.colorView.backgroundColor = data
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
