//
//  CustomerMyOrderViewController.swift
//  Gomble
//
//  Created by mobileworld on 9/15/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import ImageSlideshow
import XLPagerTabStrip
import SDWebImage
import JGProgressHUD
import SwiftyJSON

class CustomerMyOrderViewController: BaseViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var orders = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView(frame: CGRect.zero)

        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        APIManager.getMyOrders{ json in
            hud.dismiss()
            if json["success"].boolValue {
                self.orders = json["res"].arrayValue
                self.tableView.reloadData()
            }
            else {
                Globals.alert(context: self, title: "Preview Techpack", message: json["message"].stringValue)
            }
        }

        
    }
}
extension CustomerMyOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "order_cell";
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID as String)!
        cell.selectionStyle = .none
        
        let imageUrl = APIManager.fullGeneralInfoImagePath(name: orders[indexPath.row]["image"].stringValue)
        let image = cell.viewWithTag(100) as! UIImageView
        image.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "test1.png"))
        
        let titleLabel = cell.viewWithTag(101) as! UILabel
        titleLabel.text = orders[indexPath.row]["techpack_title"].stringValue
        
        let priceLabel = cell.viewWithTag(102) as! UILabel
        priceLabel.text = orders[indexPath.row]["price"].floatValue.currencyFormattedStr()
        
        let stateLabel = cell.viewWithTag(103) as! UILabel
        stateLabel.text = orders[indexPath.row]["paid_state"].stringValue
        
        let designerNameLabel = cell.viewWithTag(104) as! UILabel
        designerNameLabel.text = "\(orders[indexPath.row]["seller_first_name"].stringValue) \(orders[indexPath.row]["seller_last_name"].stringValue)"
                
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
