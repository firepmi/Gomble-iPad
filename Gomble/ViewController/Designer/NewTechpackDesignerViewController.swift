//
//  NewTechpackDesignerViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/20/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import ExpandableCell


class NewTechpackDesignerViewController: DefaultViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewButtonView: UIView!
    @IBOutlet weak var tableView: ExpandableTableView!
        
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        type = "designer"
        titleLabel.text = "New techpack"
        previewButtonView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 13.5)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.expandableDelegate = self
        tableView.animation = .automatic
        tableView.expansionStyle = .single
        tableView.autoReleaseDelegate = false
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    override func viewDidAppear(_ animated: Bool) {
        refreshView()
    }
    func refreshView() {
        
    }
    
    @IBAction func onPreview(_ sender: Any) {
    }
    
    @IBAction func onSaveProgress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onCreateAndPublish(_ sender: Any) {
//        Testdatabase.techpacks =
        openDialog(id: "success_added") {
            self.onBack()
        }
    }
    
}

extension NewTechpackDesignerViewController: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCells[indexPath.row])
        switch indexPath.row {
        case 2:
            let view = cell?.viewWithTag(100) as! GeneralInfoView
            view.delegate = self
        case 3:
            let view = cell?.viewWithTag(100) as! SketchesView
            view.delegate = self
            view.onHightChanged = { height in
                self.categoryHeights[3] = height
                self.tableView.close(at: IndexPath(row: 3, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 3, section: 0))
                }
            }
        case 4:
            let view = cell?.viewWithTag(100) as! MaterialView
            view.delegate = self
            view.onHightChanged = { height in
                self.categoryHeights[4] = height
                self.tableView.close(at: IndexPath(row: 4, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 4, section: 0))
                }
            }
        case 5:
            let view = cell?.viewWithTag(100) as! MeasurementsView
            view.delegate = self
            view.onHightChanged = { height in
                self.categoryHeights[5] = height
                self.tableView.close(at: IndexPath(row: 5, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 5, section: 0))
                }
            }
        case 6:
            let view = cell?.viewWithTag(100) as! PatternView
            view.delegate = self
            view.onHightChanged = { height in
                self.categoryHeights[6] = height
                self.tableView.close(at: IndexPath(row: 6, section: 0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.tableView.open(at: IndexPath(row: 6, section: 0))
                }
            }
        case 9:
            let view = cell?.viewWithTag(100) as! ReadyToWearView
            view.delegate = self
            view.onHightChanged = { height in
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


