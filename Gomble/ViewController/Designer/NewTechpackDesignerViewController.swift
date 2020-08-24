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

    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewButtonView: UIView!
    @IBOutlet weak var tableView: ExpandableTableView!
    
    var hiddenSections = Set<Int>()
    
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
}

extension NewTechpackDesignerViewController: ExpandableDelegate {
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCells[indexPath.row])
        if indexPath.row == 2 {
            let view = cell?.viewWithTag(100) as! GeneralInfoView
            view.delegate = self
        }
        else if indexPath.row == 3 {
            let view = cell?.viewWithTag(100) as! SketchesView
            view.delegate = self
        }
        
        cell?.selectionStyle = .none
        return [cell!]
    }

    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        
        switch indexPath.row {
            case 0:
                return [425] //Collaboration
            case 1:
                return [590] //Stage
            case 2:
                return [650] //General info
            case 3:
                return [280] //Sketches
            case 4:
                return [150]
            case 5:
                return [160]
            case 6:
                return [170]
            case 7:
                return [180]
            case 8:
                return [190]
            case 9:
                return [200]
            default:
                break
            }
        return nil
        
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

class ExpandableInitiallyExpanded: ExpandableCell {
    override func isSelectable() -> Bool {
        return true
    }
    
    override func isInitiallyExpanded() -> Bool {
        return true
    }
}
