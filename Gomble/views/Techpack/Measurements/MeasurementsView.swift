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
class MeasurementsView: DefaultView {
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var iconInches: UIImageView!
    @IBOutlet weak var iconCenti: UIImageView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tagListViewWidth: NSLayoutConstraint!
    var unit = "cemti"
    var delegate:DefaultViewController?
    var viewHeight:CGFloat = 432
    let cellID = "measurementCell";
    var onHightChanged : ((CGFloat)->Void)?
    var measurementData:[JSON] = Testdatabase.measurementData {
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
//                tableView.alwaysBounceVertical = false
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
        
        if Testdatabase.sizeRangeData.count == 0 {
            Testdatabase.sizeRangeData.arrayObject = ["XS","S","M","L",]
        }
        tagListView.removeAllTags()
        for tag in Testdatabase.sizeRangeData.arrayValue {
            self.tagListView.addTag(tag.stringValue)
        }
        tagListViewWidth.constant = tagListView.tagViewWidth
        tagListView.layoutIfNeeded()
        tagListView.delegate = self
        measurementData = Testdatabase.measurementData
    }
    @IBAction func onInches(_ sender: Any) {
        unit = "inchi"
        iconInches.image = UIImage(named: "icon_radio_on.png")
        iconCenti.image = UIImage(named: "icon_radio_off_grey.png")
        
    }
    @IBAction func onCentimeter(_ sender: Any) {
        unit = "cemti"
        iconInches.image = UIImage(named: "icon_radio_off_grey.png")
        iconCenti.image = UIImage(named: "icon_radio_on.png")
    }
    @IBAction func onAddMeasurement(_ sender: Any) {
        delegate?.openDialog(id: "add_measurement", completion: {
            self.measurementData = Testdatabase.measurementData
        })
    }
    @IBAction func onAddSizeRange(_ sender: Any) {
        delegate?.openDialog(id: "select_sizes", completion: {
            self.tagListView.removeAllTags()
            for tag in Testdatabase.sizeRangeData.arrayValue {
                self.tagListView.addTag(tag.stringValue)
            }
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
        Testdatabase.sizeRangeData.arrayObject = Testdatabase.sizeRangeData.arrayValue.filter{ $0.stringValue != title}
    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title)
        tagListViewWidth.constant = tagListView.tagViewWidth
        tagListView.layoutIfNeeded()
        Testdatabase.sizeRangeData.arrayObject = Testdatabase.sizeRangeData.arrayValue.filter{ $0.stringValue != title}
    }
}
