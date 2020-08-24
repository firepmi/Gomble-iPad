//
//  CollaborationView.swift
//  Gomble
//
//  Created by mobileworld on 8/20/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class CollaborationView: DefaultView, UITableViewDelegate, UITableViewDataSource {
            
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var inviteTextField: RoundedTextField!
    var contactsData:[JSON] = [JSON]() {
        didSet {
            tableView.reloadData()
            if contactsData.count == 0 {
                emptyView.isHidden = false
                tableView.isHidden = true
            }
            else {
                emptyView.isHidden = true
                tableView.isHidden = false
            }
        }
    }
    
    override func setNibName() {
        nibName = "CollaborationView"
    }
    
    override func initView() {
        contactsData = Testdatabase.getTestColaborationData()
        tableView.register(UINib(nibName: "CollaborationTableViewCell", bundle: nil), forCellReuseIdentifier: "collaborationTableViewCell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
   
    @IBAction func onCopyLink(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "collaborationTableViewCell";
        let cell:CollaborationTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! CollaborationTableViewCell
        cell.selectionStyle = .none
        
        let data = contactsData[indexPath.row]
        
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
        return 78
    }
    
}
