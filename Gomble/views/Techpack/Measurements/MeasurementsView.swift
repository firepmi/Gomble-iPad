//
//  MeasurementsView.swift
//  Gomble
//
//  Created by mobileworld on 8/26/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class MeasurementsView: BaseView {
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var iconInches: UIImageView!
    @IBOutlet weak var iconCenti: UIImageView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tagListViewWidth: NSLayoutConstraint!
    var unit = "cm"
    var tags = ["XS","S","M","L",]
    var delegate:BaseViewController?
    var viewHeight:CGFloat = 432
    let cellID = "measurementCell";
    var onHightChanged : ((CGFloat)->Void)?
    var measurementData:[JSON] = [] {
        didSet {
            tableView.reloadData()
            tableView.layoutIfNeeded()
            if measurementData.count == 0 {
                emptyView.isHidden = false
                dataView.isHidden = true
            }
            else {
                emptyView.isHidden = true
                dataView.isHidden = false
                self.tableViewHeight.constant = 80 * CGFloat(self.measurementData.count)
                self.tableView.setNeedsUpdateConstraints()
                self.tableView.layoutIfNeeded()
                viewHeight = CGFloat(tableViewHeight.constant + 320)
                if (onHightChanged != nil) {
                    onHightChanged!(viewHeight)
                }
            }
            tableView.layoutIfNeeded()
        }
    }
    override func setNibName() {
        nibName = "MeasurementsView"
    }
    override func initView() {
        tableView.register(UINib(nibName: "MeasurementCell", bundle: nil), forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        tagListView.removeAllTags()
        self.tagListView.addTags(tags)
        tagListViewWidth.constant = tagListView.tagViewWidth
        tagListView.layoutIfNeeded()
        tagListView.delegate = self
        
        if unit == "cm" {
            iconInches.image = UIImage(named: "icon_radio_off_grey.png")
            iconCenti.image = UIImage(named: "icon_radio_on.png")
        }
        else {
            iconInches.image = UIImage(named: "icon_radio_on.png")
            iconCenti.image = UIImage(named: "icon_radio_off_grey.png")
        }
        getData()
    }
    func getData(){
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.getMeasurements(param: param) { json in
            if json["success"].boolValue {
                self.measurementData = json["res"].arrayValue
                self.tableView.reloadData()
            }
            else {
                self.makeToast(json["message"].stringValue)
            }
        }
        APIManager.getMeasurementBasicInfo(param: param) { json in
            if json["success"].boolValue {
                self.refreshView(json: json["res"])
                self.tableView.reloadData()
            }
            else {
                self.makeToast(json["message"].stringValue)
            }
        }
    }
    func refreshView(json:JSON){
        tags = []
        for tag in json["size_range"].arrayValue {
            tags.append(tag.stringValue)
        }
        tagListView.removeAllTags()
        self.tagListView.addTags(tags)
        tagListViewWidth.constant = tagListView.tagViewWidth
        tagListView.layoutIfNeeded()
        
        unit = json["unit"].stringValue
        if unit == "cm" {
            iconInches.image = UIImage(named: "icon_radio_off_grey.png")
            iconCenti.image = UIImage(named: "icon_radio_on.png")
        }
        else {
            iconInches.image = UIImage(named: "icon_radio_on.png")
            iconCenti.image = UIImage(named: "icon_radio_off_grey.png")
        }
    }
    func updateData(completion:((JSON)->Void)?){
        var tagStr = ""
        for tag in tags {
            tagStr = tagStr + tag + ","
        }
        if tagStr.count != 0 {
            tagStr = tagStr[0..<tagStr.count-1]
        }
        var param = [String:String]()
        
        param["unit"] = unit
        param["size_ranges"] = tagStr
        param["techpack_id"] = Globals.techpackID
        
        APIManager.updateMeasurementBasicInfo(param: param, completion: completion)
    }
    @IBAction func onInches(_ sender: Any) {
        unit = "inch"
        iconInches.image = UIImage(named: "icon_radio_on.png")
        iconCenti.image = UIImage(named: "icon_radio_off_grey.png")
        
    }
    @IBAction func onCentimeter(_ sender: Any) {
        unit = "cm"
        iconInches.image = UIImage(named: "icon_radio_off_grey.png")
        iconCenti.image = UIImage(named: "icon_radio_on.png")
    }
    @IBAction func onAddMeasurement(_ sender: Any) {
        Globals.unit = unit
        Globals.sizeRanges = tags
        delegate?.openDialog(id: "add_measurement", completion: {
            self.getData()
        })
    }
    @IBAction func onAddSizeRange(_ sender: Any) {
        Globals.sizeRanges = tags
        delegate?.openDialog(id: "select_sizes", completion: {
            self.tags = Globals.sizeRanges
            self.tagListView.removeAllTags()
            self.tagListView.addTags(self.tags)
            self.tagListViewWidth.constant = self.tagListView.tagViewWidth
            self.tagListView.layoutIfNeeded()
            self.tagListView.delegate = self
        })
    }
}

extension MeasurementsView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measurementData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MeasurementCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MeasurementCell
        cell.selectionStyle = .none
        
        let data = measurementData[indexPath.row]
        
        cell.titleLabel.text = data["title"].stringValue
        cell.descriptionLabel.text = data["description"].stringValue
        let ranges = data["size_range"].arrayValue
        var tagStr = ""
        for tag in ranges {
            tagStr = tagStr + tag.stringValue + ", "
        }
        if tagStr.count > 1 {
            tagStr = tagStr[0..<tagStr.count-2]
        }
        cell.sizeRangeLabel.text = tagStr
        cell.tolLabel.text = data["tol"].stringValue
        let imageUrl = APIManager.fullMeasurementPath(name: data["image"].stringValue)
        cell.measurementImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "test_measurement.png"))
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
extension MeasurementsView: TagListViewDelegate {
    func tagAddedPressed(_ title: String, sender: TagListView) {
        tagListView.addTag(title)
    }
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title)
        tagListViewWidth.constant = tagListView.tagViewWidth
        tagListView.layoutIfNeeded()
        tags = tags.filter{ $0 != title}
    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title)
        tagListViewWidth.constant = tagListView.tagViewWidth
        tagListView.layoutIfNeeded()
        tags = tags.filter{ $0 != title}
    }
}
