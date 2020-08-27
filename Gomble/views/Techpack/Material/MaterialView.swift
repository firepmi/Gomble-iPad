//
//  MaterialView.swift
//  Gomble
//
//  Created by mobileworld on 8/24/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class MaterialView: DefaultView {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate:DefaultViewController?
    var viewHeight:CGFloat = 280
    let cellID = "materialTableViewCell";
    var onHightChanged : ((CGFloat)->Void)?
    var materialData:[JSON] = Testdatabase.materialData {
        didSet {
            tableView.reloadData()
            tableView.layoutIfNeeded()
            if materialData.count == 0 {
                emptyView.isHidden = false
                dataView.isHidden = true
            }
            else {
                emptyView.isHidden = true
                dataView.isHidden = false
                self.tableViewHeight.constant = 80 * CGFloat(self.materialData.count)
                self.tableView.setNeedsUpdateConstraints()
                self.tableView.layoutIfNeeded()
//                tableView.alwaysBounceVertical = false
                viewHeight = CGFloat(tableViewHeight.constant + 120)
                if (onHightChanged != nil) {
                    onHightChanged!(viewHeight)
                }
            }
            tableView.layoutIfNeeded()
        }
    }
    override func setNibName() {
        nibName = "MaterialView"
    }
    override func initView() {
        tableView.register(UINib(nibName: "MaterialTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        materialData = Testdatabase.sketchData
    }
    @IBAction func onAddItem(_ sender: Any) {
        delegate?.openDialog(id: "add_material_item", completion: {
            self.materialData = Testdatabase.materialData
        })
    }
    @IBAction func importCSV(_ sender: Any) {
    }
}
extension MaterialView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materialData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MaterialTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MaterialTableViewCell
        cell.selectionStyle = .none
        
        let data = materialData[indexPath.row]
        
        cell.titleLabel.text = data["title"].stringValue
        cell.descriptionLabel.text = data["description"].stringValue
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

