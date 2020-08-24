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
    let cellID = "sketchesTableViewCell";
    var sketchesData:[JSON] = [JSON]() {
        didSet {
            tableView.reloadData()
            if sketchesData.count == 0 {
                emptyView.isHidden = false
                dataView.isHidden = true
            }
            else {
                emptyView.isHidden = true
                dataView.isHidden = false
            }
        }
    }
    override func setNibName() {
        nibName = "SketchesView"
    }
    override func initView() {
        tableView.register(UINib(nibName: "SketchTableViewCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    @IBAction func onAddSketch(_ sender: Any) {
        
    }
}
extension SketchesView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sketchesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CollaborationTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CollaborationTableViewCell
        cell.selectionStyle = .none
        
        let data = sketchesData[indexPath.row]
        
        let firstName = data["first_name"].stringValue
        let lastName = data["last_name"].stringValue
        let email = data["email"].stringValue
        var indicateStr = ""
        if firstName.count > 0 { indicateStr = firstName[0..<1] }
        if lastName.count > 0 { indicateStr += lastName[0..<1] }
        if indicateStr.count == 0 { indicateStr = email[0..<1] }
        cell.profileIndicatorLabel.text = indicateStr
        cell.nameLabel.text = "\(firstName) \(lastName)"
        cell.emailLabel.text = email

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
}
