//
//  StageView.swift
//  Gomble
//
//  Created by mobileworld on 8/21/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import JGProgressHUD

@IBDesignable
class StageView: BaseView {
    var selectedColor = UIColor.init(hexString:"#4B62FF")
    
    @IBOutlet weak var tableView: UITableView!
    let cellID = "stageTableViewCell"
    var menuData = ["Idea", "Sample","Production"]
    var startDateData = ["","",""]
    var selectedIndex = 0
    
    override func setNibName() {
        nibName = "StageView"
    }
    override func initView() {
        tableView.register(UINib(nibName: "StageTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
    }
    func updateData(){
        let cell = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0)) as! StageTableViewCell
        var param = [String:String]()
        param["title"] = cell.titleLabel.text
        param["start_date"] = cell.startDateLabel.text
        param["end_date"] = cell.endDateLabel.text
        param["completion"] = "\(cell.completion)"
        param["techpack_id"] = Globals.techpackID
        
        APIManager.updateStage(param: param) { json in
            if json["success"].boolValue {
                print(json["message"].stringValue)
            }
            else {
                self.makeToast(json["message"].stringValue)
            }
        }
    }
    
}
extension StageView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! StageTableViewCell
        cell.selectionStyle = .none
        
        cell.titleLabel.text = menuData[indexPath.row]
        cell.containerView.borderColor = selectedColor
        if selectedIndex == indexPath.row {
            cell.isSelected = true
            cell.containerView.borderColor = selectedColor
            cell.iconRadioImageView.image = UIImage(named: "icon_radio_on_grey.png")
            cell.containerView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
        }
        else {
            cell.isSelected = false
            cell.containerView.borderColor = .clear
            cell.iconRadioImageView.image = UIImage(named: "icon_radio_off_grey.png")
            cell.containerView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 5, scale: true)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 192
    }
    
}
