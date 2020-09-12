//
//  SketchesView.swift
//  Gomble
//
//  Created by mobileworld on 8/24/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON
import JGProgressHUD

@IBDesignable
class SketchesView: BaseView {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate:BaseViewController?
    var viewHeight:CGFloat = 280
    let cellID = "sketchesTableViewCell"
    var onHightChanged : ((CGFloat)->Void)?
    var sketchesData:[JSON] = [] {
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
        self.getData()
    }
    @IBAction func onAddSketch(_ sender: Any) {
        delegate?.openDialog(id: "add_sketch", completion: {
            self.getData()
        })
    }
    func getData(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self)
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.getSketches(param: param) { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.sketchesData = json["res"].arrayValue
            }
            else {
                self.makeToast(json["message"].stringValue)
            }
        }
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
        if (data["image"].string != nil) {
            let imageUrl = "\(APIManager.imageUrl)sketches/\(data["image"].stringValue)"
            print(imageUrl)
            cell.sketchimageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "test_sketch.png"))
        }
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
