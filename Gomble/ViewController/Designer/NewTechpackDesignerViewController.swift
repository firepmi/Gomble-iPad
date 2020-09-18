//
//  NewTechpackDesignerViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/20/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import ExpandableCell
import SwiftyJSON
import JGProgressHUD

class NewTechpackDesignerViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewButtonView: UIView!
    @IBOutlet weak var tableView: ExpandableTableView!
        
    @IBOutlet weak var publishButtonLabel: UILabel!
    @IBOutlet weak var saveButtonLabel: UILabel!
    @IBOutlet weak var saveButtonView: RoundedView!
    @IBOutlet weak var saveIcon: UIImageView!
    
    let categoryCells = [
        "collaboration_cell",
         "stage_cell",
         "general_info_cell",
         "sketches_cell",
         "materials_cell",
         "measurements_cell",
         "pattern_cell",
         "factory_cell",
         "price_cell",
         "ready_to_wear_cell"
    ]
    let categoryTitles = [
        "Collaboration",
        "Stage",
        "General info",
        "Sketches",
        "Materials, accessories",
        "Measurements",
        "Pattern/ 3D Pattern",
        "Factory",
        "Price",
        "Ready to wear product"
    ]
    var categoryHeights:[CGFloat] = [
        425, //Collaboration
        590, //Stage
        650, //General info
        280, //Sketches
        280, //Material / accessories
        432, //Measurements
        280, //Pattern
        330, //Factory
        330, //Price
        330, //Ready to wear product
    ]
    var currentIndex = 0
    var stageView: StageView?
    var generalInfoView: GeneralInfoView?
    var sketchesView: SketchesView?
    var materialView: MaterialView?
    var measurementsView: MeasurementsView?
    var patternView: PatternView?
    var factoryView: FactoryView?
    var priceView: PriceView?
    var readyToWearView: ReadyToWearView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        type = "designer"
        if Globals.isNew {
            titleLabel.text = "New Techpack"
            publishButtonLabel.text = "Create and publish"
            saveButtonLabel.text = "Save progress"
        }
        else {
            titleLabel.text = "Edit Techpack"
            publishButtonLabel.text = "Save"
            saveIcon.isHidden = true
            saveButtonLabel.text = "Delete techpack"
        }
        previewButtonView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 13.5)
        
        if Globals.isNew {
            let hud = JGProgressHUD(style: .dark)
            hud.textLabel.text = "Please wait..."
            hud.show(in: self.view)
            APIManager.getDraft(param: ["folder_id" : Globals.folderID]) { json in
                hud.dismiss()
                if json["success"].boolValue {
                    Globals.techpackID = json["res"].stringValue
                }
                else {
                    Globals.alert(context: self, title: "New Techpack", message: json["message"].stringValue)
                    self.onBack()
                }
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
    
    @IBAction func onPreview(_ sender: Any) {
    }
    func updateData(completion:((JSON)->Void)?) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading Stage Data..."
        hud.show(in: self.view)
        stageView?.updateData{ json in
            hud.dismiss()
            if json["success"].boolValue {
                self.updateGeneralInfo(completion: completion)
            }
            else {
                completion?(json)
            }
        }
    }
    func updateGeneralInfo(completion:((JSON)->Void)?) {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Upload General Info..."
        hud.show(in: self.view)
        generalInfoView?.updateData{ json in
            hud.dismiss()
            if json["success"].boolValue {
                self.updateSketchData(completion: completion)
            }
            else {
                completion?(json)
            }
        }
    }
    func updateSketchData(completion:((JSON)->Void)?){
        if sketchesView?.sketchesData.count == 0 {
            let alert = UIAlertController(title: "Publish Techpack", message: "No sketch data added, Do you want add it?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                
            }))
            alert.addAction(UIAlertAction(title: "No, Thanks", style: .cancel, handler: { (_) in
                self.updateMaterialData(completion: completion)
            }))
            present(alert, animated: true, completion: nil)
        }
        else {
            self.updateMaterialData(completion: completion)
        }
    }
    func updateMaterialData(completion:((JSON)->Void)?){
        if materialView?.materialData.count == 0 {
            let alert = UIAlertController(title: "Publish Techpack", message: "No material data added, Do you want add it?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                
            }))
            alert.addAction(UIAlertAction(title: "No, Thanks", style: .cancel, handler: { (_) in
                self.updateMeasurementBasicInfo(completion: completion)
            }))
            present(alert, animated: true, completion: nil)
        }
        else {
            self.updateMeasurementBasicInfo(completion: completion)
        }
    }
    func updateMeasurementBasicInfo(completion:((JSON)->Void)?){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading Measurement Info..."
        hud.show(in: self.view)
        measurementsView?.updateData{ json in
            hud.dismiss()
            if json["success"].boolValue {
                self.updateMeasurementData(completion: completion)
            }
            else {
                completion?(json)
            }
        }
    }
    func updateMeasurementData(completion:((JSON)->Void)?){
        if materialView?.materialData.count == 0 {
            let alert = UIAlertController(title: "Publish Techpack", message: "No measurement data added, Do you want add it?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                
            }))
            alert.addAction(UIAlertAction(title: "No, Thanks", style: .cancel, handler: { (_) in
                self.updatePatternData(completion: completion)
            }))
            present(alert, animated: true, completion: nil)
        }
        else {
            self.updatePatternData(completion: completion)
        }
    }
    func updatePatternData(completion:((JSON)->Void)?){
        if patternView?.patternData.count == 0 {
            let alert = UIAlertController(title: "Publish Techpack", message: "No pattern data added, Do you want add it?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                
            }))
            alert.addAction(UIAlertAction(title: "No, Thanks", style: .cancel, handler: { (_) in
                self.updateFactoryData(completion: completion)
            }))
            present(alert, animated: true, completion: nil)
        }
        else {
            self.updateFactoryData(completion: completion)
        }
    }
    func updateFactoryData(completion:((JSON)->Void)?){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading Factory Data..."
        hud.show(in: self.view)
        factoryView?.updateData{ json in
            hud.dismiss()
            if json["success"].boolValue {
                self.updatePriceData(completion: completion)
            }
            else {
                completion?(json)
            }
        }
    }
    func updatePriceData(completion:((JSON)->Void)?){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading Price Data..."
        hud.show(in: self.view)
        priceView?.updateData{ json in
            hud.dismiss()
            if json["success"].boolValue {
                self.updateReadyToWear(completion: completion)
            }
            else {
                completion?(json)
            }
        }
    }
    func updateReadyToWear(completion:((JSON)->Void)?){
        var json = JSON()
        json["success"].bool = true
        if readyToWearView?.readyToWearData.count == 0 {
            let alert = UIAlertController(title: "Publish Techpack", message: "No ready to wear data added, Do you want add it?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                
            }))
            alert.addAction(UIAlertAction(title: "No, Thanks", style: .cancel, handler: { (_) in
                completion?(json)
            }))
            present(alert, animated: true, completion: nil)
        }
        else {
            completion?(json)
        }
    }
    @IBAction func onSaveProgress(_ sender: Any) {
        if Globals.isNew {
            stageView?.updateData(completion: nil)
            generalInfoView?.updateData(completion: nil)
            measurementsView?.updateData(completion: nil)
            factoryView?.updateData(completion: nil)
            priceView?.updateData(completion: nil)
            self.onBack()
        }
        else {
            let alert = UIAlertController(title: "Delete Techpack", message: "Do you want remove this techpack? This action cannot be undone.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete anyway", style: .default, handler: { (_) in
                self.deleteTechpack()
            }))
            alert.addAction(UIAlertAction(title: "keep it", style: .cancel, handler: { (_) in
                
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    func deleteTechpack(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.deleteTechpack(param: param) { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.onBack()
            }
            else {
                Globals.alert(context: self, title: "Delete Techpack", message: json["message"].stringValue)
            }
        }
    }
    @IBAction func onCreateAndPublish(_ sender: Any) {
        if stageView == nil || generalInfoView == nil ||
            sketchesView == nil || materialView == nil || factoryView == nil ||
            priceView == nil || patternView == nil || readyToWearView == nil {
            Globals.alert(context: self, title: "New Techpack", message: "Please fill all fields")
            return
        }
        updateData { json in
            if json["success"].boolValue {
                self.publishTechpack()
            }
            else {
                Globals.alert(context: self, title: "Publish Techpack", message: json["message"].stringValue)
            }
        }
    }
    func publishTechpack(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.publishTechpack(param: param) { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.openDialog(id: "success_added") {
                    self.onBack()
                }
            }
            else {
                Globals.alert(context: self, title: "New Techpack", message: json["message"].stringValue)
            }
        }
    }
}

extension NewTechpackDesignerViewController: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCells[indexPath.row])
        switch indexPath.row {
        case 1:
            stageView = cell?.viewWithTag(100) as? StageView
        case 2:
            generalInfoView = cell?.viewWithTag(100) as? GeneralInfoView
            generalInfoView!.delegate = self
        case 3:
            sketchesView = cell?.viewWithTag(100) as? SketchesView
            sketchesView!.delegate = self
            sketchesView!.onHightChanged = { height in
                self.categoryHeights[3] = height
                self.tableView.close(at: IndexPath(row: 3, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 3, section: 0))
                }
            }
        case 4:
            materialView = cell?.viewWithTag(100) as? MaterialView
            materialView!.delegate = self
            materialView!.onHightChanged = { height in
                self.categoryHeights[4] = height
                self.tableView.close(at: IndexPath(row: 4, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 4, section: 0))
                }
            }
        case 5:
            measurementsView = cell?.viewWithTag(100) as? MeasurementsView
            measurementsView!.delegate = self
            measurementsView!.onHightChanged = { height in
                self.categoryHeights[5] = height
                self.tableView.close(at: IndexPath(row: 5, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 5, section: 0))
                }
            }
        case 6:
            patternView = cell?.viewWithTag(100) as? PatternView
            patternView!.delegate = self
            patternView!.onHightChanged = { height in
                self.categoryHeights[6] = height
                self.tableView.close(at: IndexPath(row: 6, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 6, section: 0))
                }
            }
        case 7:
            factoryView = cell?.viewWithTag(100) as? FactoryView
        case 8:
            priceView = cell?.viewWithTag(100) as? PriceView
        case 9:
            readyToWearView = cell?.viewWithTag(100) as? ReadyToWearView
            readyToWearView?.delegate = self
            readyToWearView?.onHightChanged = { height in
                self.categoryHeights[9] = height
                self.tableView.close(at: IndexPath(row: 9, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 9, section: 0))
                }
            }
        default:
            break
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


