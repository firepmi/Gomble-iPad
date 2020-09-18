//
//  ReadyToWearView.swift
//  Gomble
//
//  Created by mobileworld on 8/27/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class ReadyToWearView: BaseView {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate:BaseViewController?
    var viewHeight:CGFloat = 280
    let cellID = "readyToWearCell";
    var onHightChanged : ((CGFloat)->Void)?
    var readyToWearData:[JSON] = [] {
        didSet {
            tableView.reloadData()
            tableView.layoutIfNeeded()
            if readyToWearData.count == 0 {
                emptyView.isHidden = false
                dataView.isHidden = true
            }
            else {
                emptyView.isHidden = true
                dataView.isHidden = false
                self.tableViewHeight.constant = 130 * CGFloat(self.readyToWearData.count)
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
        nibName = "ReadyToWearView"
    }
    override func initView() {
        tableView.register(UINib(nibName: "ReadyToWearCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        getData()
    }
    func getData(){
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.getReadyToWears(param: param) { json in
            if json["success"].boolValue {
                self.readyToWearData = json["res"].arrayValue
                self.tableView.reloadData()
            }
            else {
                self.makeToast(json["message"].stringValue)
            }
        }
    }
    @IBAction func onAddImage(_ sender: Any) {
        delegate?.openDialog(id: "add_ready_to_wear", completion: {
            self.getData()
        })
    }
}
extension ReadyToWearView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readyToWearData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ReadyToWearCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! ReadyToWearCell
        cell.selectionStyle = .none
        
        let data = readyToWearData[indexPath.row]
        
        cell.titleLabel.text = data["title"].stringValue
        cell.descriptionLabel.text = data["description"].stringValue
        let imageUrl = APIManager.fullReadyToWearImagePath(name: data["image"].stringValue)
        cell.productImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "test1.png"))
        cell.onDeleteClicked(){
            print("deleted")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
}

