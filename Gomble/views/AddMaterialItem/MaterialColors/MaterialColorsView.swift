//
//  MaterialColorsView.swift
//  Gomble
//
//  Created by mobileworld on 8/25/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON
import EFColorPicker

@IBDesignable
class MaterialColorsView: BaseView {
    var delegate:UIViewController?
    @IBOutlet weak var tableView: UITableView!
    var selectedColor = UIColor.red
    var colorData:[JSON] = [] {
            didSet {
                tableView.reloadData()
//                tableView.layoutIfNeeded()
//                if materialData.count == 0 {
//                    emptyView.isHidden = false
//                    dataView.isHidden = true
//                }
//                else {
//                    emptyView.isHidden = true
//                    dataView.isHidden = false
//                    self.tableViewHeight.constant = 70 * CGFloat(self.materialData.count)
//                    self.tableView.setNeedsUpdateConstraints()
//                    self.tableView.layoutIfNeeded()
//    //                tableView.alwaysBounceVertical = false
//                    viewHeight = CGFloat(tableViewHeight.constant + 120)
//                    if (onHightChanged != nil) {
//                        onHightChanged!(viewHeight)
//                    }
//                }
            }
        }
    var cellID = "MaterialColorCell"
    override func setNibName() {
        nibName = "MaterialColorsView"
    }
    override func initView() {
        tableView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        getData()
    }
    func getData(){
        var param = [String:String]()
        param["material_id"] = Globals.materialID
        APIManager.getMaterialColor(param: param) { json in
            if json["success"].boolValue {
                self.colorData = json["res",0,"color_list"].arrayValue
                print(self.colorData)
                self.tableView.reloadData()
            }
            else {
                self.makeToast(json["message"].stringValue)
            }
        }
    }
    @IBAction func onAddItem(_ sender: UIButton) {
        let colorSelectionController = EFColorSelectionViewController()
        let navCtrl = UINavigationController(rootViewController: colorSelectionController)
        navCtrl.navigationBar.backgroundColor = UIColor.white
        navCtrl.navigationBar.isTranslucent = false
        navCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
        navCtrl.popoverPresentationController?.delegate = self
        navCtrl.popoverPresentationController?.sourceView = sender
        navCtrl.popoverPresentationController?.sourceRect = sender.bounds
        navCtrl.preferredContentSize = colorSelectionController.view.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )

        colorSelectionController.delegate = self
        colorSelectionController.color = .red
        colorSelectionController.setMode(mode: EFColorSelectionMode.all)

//        if UIUserInterfaceSizeClass.compact == self.traitCollection.horizontalSizeClass {
            let doneBtn: UIBarButtonItem = UIBarButtonItem(
                title: NSLocalizedString("Done", comment: ""),
                style: .done,
                target: self,
                action: #selector(ef_dismissViewController(sender:))
            )
            colorSelectionController.navigationItem.rightBarButtonItem = doneBtn
//        }
        delegate?.present(navCtrl, animated: true, completion: nil)
    }
    @objc func ef_dismissViewController(sender: UIBarButtonItem) {
        delegate?.dismiss(animated: true, completion: {
            var param = [String:String]()
            param["material_id"] = Globals.materialID
            param["code"] = self.selectedColor.toHex
            APIManager.addMaterialColor(param: param) { json in
                if json["success"].boolValue {
                    self.getData()
                }
                else {
                    self.makeToast(json["message"].stringValue)
                }
            }
        })
    }
}
extension MaterialColorsView: EFColorSelectionViewControllerDelegate, UIPopoverPresentationControllerDelegate {
    func colorViewController(_ colorViewCntroller: EFColorSelectionViewController, didChangeColor color: UIColor) {  selectedColor = color
    }
}
extension MaterialColorsView:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MaterialColorCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! MaterialColorCell
        cell.selectionStyle = .none
        
        let colorCode = "#\(colorData[indexPath.row]["code"].stringValue)"
        
        cell.colorView.backgroundColor = UIColor(hexString: colorCode)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
