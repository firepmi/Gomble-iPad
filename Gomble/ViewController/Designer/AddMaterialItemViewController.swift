//
//  AddMaterialItemViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/25/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import ExpandableCell
import SwiftyJSON
import JGProgressHUD
import Alamofire

class AddMaterialItemViewController: BaseDialogViewController {
    let categoryCells = [
        "image_cell",
        "general_info_cell",
        "colors_cell",
        "quantity_cell",
        "supplier_cell"
    ]
    let categoryTitles = [
        "Image",
        "General info",
        "Colors",
        "Quantity",
        "Supplier/Vendor"
    ]
    var categoryHeights:[CGFloat] = [
        356, //Image
        380, //Stage
        300, //Colors
        200, //Quantity
        330, //Supplier /Vendor
    ]
    var addItemImageSelectView: AddItemImageSelectView?
    var materialGeneralInfoView: MaterialGeneralInfoView?
    var materialColorView: MaterialColorsView?
    var materialQuantityView: MaterialQuantityView?
    var materialSupplierView: MaterialSupplierView?
    
    @IBOutlet weak var tableView: ExpandableTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        print(Globals.folderID)
        APIManager.getMaterialDraft(param: ["techpack_id" : Globals.techpackID]) { json in
            hud.dismiss()
            if json["success"].boolValue {
                Globals.materialID = json["res"].stringValue
            }
            else {
                Globals.alert(context: self, title: "New Meterial", message: json["message"].stringValue)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.expandableDelegate = self
        tableView.animation = .automatic
        tableView.expansionStyle = .single
        tableView.autoReleaseDelegate = false
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    @IBAction func onAddItem(_ sender: Any) {
//        data["title"].string = "Main fabric"
//        data["description"].string = "Fabric content: 100% cotten\nFabric weight: 160 - 180 GSM"

        
        if materialGeneralInfoView == nil ||
            materialColorView == nil ||
            materialQuantityView  == nil ||
            materialSupplierView  == nil {
            Globals.alert(context: self, title: "New Material", message: "Please add allow fields")
            return
        }
        let multipartFormData = MultipartFormData()
        var tagStr = ""
        for tag in materialGeneralInfoView!.tags {
            tagStr = tagStr + tag + ","
        }
        if tagStr.count != 0 {
            tagStr = tagStr[0..<tagStr.count-1]
        }
        let title = materialGeneralInfoView!.titleTextField.text!
        let placement = materialGeneralInfoView!.placementTextField.text!
        let description = materialGeneralInfoView!.descriptionTextView.text!
        let quantity = materialQuantityView!.quantityTextField.text!
        let price_per_item = "\(materialQuantityView!.pricePerItemTextField.text!.currencyValue())"
        let price_total = "\(materialQuantityView!.totalPriceLabel.text!.currencyValue())"
        let factory_name = materialSupplierView!.factoryNameTextField.text!
        let factory_email = materialSupplierView!.emailTextField.text!
        let factory_phone = materialSupplierView!.phoneTextField.text!
        let factory_information = materialSupplierView!.informationTextView.text!
        
        if title != "" {
            multipartFormData.append(title.data(using: .utf8, allowLossyConversion: false)!, withName: "title")
        }
        if placement != "" {
            multipartFormData.append(placement.data(using: .utf8, allowLossyConversion: false)!, withName: "placement")
        }
        if description != "" {
            multipartFormData.append(description.data(using: .utf8, allowLossyConversion: false)!, withName: "description")
        }
        if tagStr != "" {
            multipartFormData.append(tagStr.data(using: .utf8, allowLossyConversion: false)!, withName: "tags")
        }
        if quantity != "" {
            multipartFormData.append(quantity.data(using: .utf8, allowLossyConversion: false)!, withName: "quantity")
        }
        if price_per_item != "" {
            multipartFormData.append(price_per_item.data(using: .utf8, allowLossyConversion: false)!, withName: "price_per_item")
        }
        if price_total != "" {
            multipartFormData.append(price_total.data(using: .utf8, allowLossyConversion: false)!, withName: "price_total")
        }
        if factory_name != "" {
            multipartFormData.append(factory_name.data(using: .utf8, allowLossyConversion: false)!, withName: "factory_name")
        }
        if factory_email != "" {
            multipartFormData.append(factory_email.data(using: .utf8, allowLossyConversion: false)!, withName: "factory_email")
        }
        if factory_phone != "" {
            multipartFormData.append(factory_phone.data(using: .utf8, allowLossyConversion: false)!, withName: "factory_phone")
        }
        if factory_information != "" {
            multipartFormData.append(factory_information.data(using: .utf8, allowLossyConversion: false)!, withName: "factory_information")
        }
        
        multipartFormData.append(Globals.techpackID.data(using: .utf8, allowLossyConversion: false)!, withName: "techpack_id")
        if addItemImageSelectView!.isImageUpdated {
            multipartFormData.append((addItemImageSelectView!.imageView.image!.jpegData(compressionQuality: 1))!, withName: "image",fileName: "generalinfo.jpg", mimeType: "image/jpg")
        }
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading..."
        hud.indicatorView = JGProgressHUDPieIndicatorView()
        hud.show(in: self.view)
        print(Globals.folderID)
        APIManager.addMaterial(param: multipartFormData, uploadProgress: { progress in
            hud.progress = Float(progress)
        }) { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.completion?()
                self.dismiss(animated: true, completion: nil)
            }
            else {
                Globals.alert(context: self, title: "New Meterial", message: json["message"].stringValue)
            }
        }
    }    
}
extension AddMaterialItemViewController: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCells[indexPath.row])
        if indexPath.row == 0 {
            addItemImageSelectView = cell?.viewWithTag(100) as? AddItemImageSelectView
            addItemImageSelectView!.delegate = self
        }
        else if indexPath.row == 1{
            materialGeneralInfoView = cell?.viewWithTag(100) as? MaterialGeneralInfoView
        }
        else if indexPath.row == 2 {
            materialColorView = cell?.viewWithTag(100) as? MaterialColorsView
            materialColorView!.delegate = self
        }
        else if indexPath.row == 3 {
            materialQuantityView = cell?.viewWithTag(100) as? MaterialQuantityView
        }
        else if indexPath.row == 4 {
            materialSupplierView = cell?.viewWithTag(100) as? MaterialSupplierView
        }
        cell?.selectionStyle = .none
        return [cell!]
    }

    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        return [categoryHeights[indexPath.row]]
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return categoryCells.count
    }

//    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectRowAt indexPath: IndexPath) {
////        print("didSelectRow:\(indexPath)")
//    }
//
//    func expandableTableView(_ expandableTableView: ExpandableTableView, didSelectExpandedRowAt indexPath: IndexPath) {
////        print("didSelectExpandedRowAt:\(indexPath)")
//    }
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cellFirst = expandableTableView.dequeueReusableCell(withIdentifier: "title_cell_first") as? ExpandableInitiallyExpanded else { return UITableViewCell() }
            let cellTitleLabel = cellFirst.viewWithTag(100) as! UILabel
            cellTitleLabel.text = categoryTitles[indexPath.row]
            cellFirst.rightMargin = 40
            cellFirst.highlightAnimation = .none
            cellFirst.selectionStyle = .none
            return cellFirst
        }
        else {
            guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: "title_cell") as? ExpandableCell else { return UITableViewCell() }
            let cellTitleLabel = cell.viewWithTag(100) as! UILabel
            cellTitleLabel.text = categoryTitles[indexPath.row]
            cell.rightMargin = 40
            cell.highlightAnimation = .none
            cell.selectionStyle = .none
            return cell
        }
    }
        
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    @objc(expandableTableView:didCloseRowAt:) func expandableTableView(_ expandableTableView: UITableView, didCloseRowAt indexPath: IndexPath) {
        let cell = expandableTableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = #colorLiteral(red: 0.3004622757, green: 0.9877796769, blue: 0.9991204143, alpha: 1)
        cell?.backgroundColor = #colorLiteral(red: 0.3004622757, green: 0.9877796769, blue: 0.9991204143, alpha: 1)
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
