//
//  DesignerSideMenuViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/19/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

class DesignerSideMenuViewController: UIViewController {
    let menus = ["My Folders","My Orders", "Team"]
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension DesignerSideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "customMenuViewCell";
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID as String)!
        cell.selectionStyle = .none
        
        let titleLabel = cell.viewWithTag(100) as! UILabel
        titleLabel.text = menus[indexPath.row]
                
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(menus[indexPath.row])
    }
}


