//
//  SketchesView.swift
//  Gomble
//
//  Created by mobileworld on 8/24/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class SketchesView: DefaultView {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate:DefaultViewController?
    var viewHeight:CGFloat = 280
    let cellID = "sketchesTableViewCell";
    var onHightChanged : ((CGFloat)->Void)?
    var sketchesData:[JSON] = Testdatabase.sketchData {
        didSet {
            tableView.reloadData()
            tableView.layoutIfNeeded()
            if sketchesData.count == 0 {
                emptyView.isHidden = false
                dataView.isHidden = true
            }
            else {
                emptyView.isHidden = true
                dataView.isHidden = false
                self.tableViewHeight.constant = 130 * CGFloat(self.sketchesData.count)
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
        nibName = "SketchesView"
    }
    override func initView() {
        tableView.register(UINib(nibName: "SketchesTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        sketchesData = Testdatabase.sketchData
    }
    @IBAction func onAddSketch(_ sender: Any) {
        delegate?.openDialog(id: "add_sketch", completion: {
            self.sketchesData = Testdatabase.sketchData
        })
    }
}
extension SketchesView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sketchesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:SketchesTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! SketchesTableViewCell
        cell.selectionStyle = .none
        
        let data = sketchesData[indexPath.row]
        
        cell.titleLabel.text = data["title"].stringValue
        cell.descriptionLabel.text = data["description"].stringValue
        cell.tagView.removeAllTags()
        for tag in data["tags"].arrayValue {
            cell.tagView.addTag(tag.stringValue)
        }
        cell.onDeleteClicked(){
            print("deleted")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
}
