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
class CollaborationView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    let nibName = "CollaborationView"
    
    var contentView:UIView?
            
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
    
    override class func awakeFromNib() {
        super.awakeFromNib()
//        commonInit(self)
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
        contactsData = Testdatabase.getTestColaborationData()
        tableView.register(UINib(nibName: "CollaborationTableViewCell", bundle: nil), forCellReuseIdentifier: "collaborationTableViewCell")
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: CustomHeaderView.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
        contentView?.prepareForInterfaceBuilder()
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
