//
//  SelectSizesViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/27/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

class SelectSizesViewController: DefaultDialogViewController {
    @IBOutlet weak var selectedTagListView: TagListView!
    @IBOutlet weak var unSelectedTagListView: TagListView!
    
    let picker:UIImagePickerController?=UIImagePickerController()
    var allTags = ["XL","L","M","XS","S","Custom+"]
    var selectedTags = [String]()
    var unselectedTags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        unselectedTags = allTags
        for tag in Testdatabase.sizeRangeData.arrayValue {
            selectedTags.append(tag.stringValue)
            unselectedTags = unselectedTags.filter{ $0 != tag.stringValue}
        }
        selectedTagListView.addTags(selectedTags)
        unSelectedTagListView.addTags(unselectedTags)
        selectedTagListView.delegate = self
        unSelectedTagListView.delegate = self
    }
    
    @IBAction func onSave(_ sender: Any) {
        Testdatabase.sizeRangeData.arrayObject = selectedTags        
        if (completion != nil) {
            completion!()
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SelectSizesViewController: TagListViewDelegate {
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if sender == selectedTagListView {
            selectedTagListView.removeTag(title)
            selectedTags = selectedTags.filter{ $0 != title}
            unselectedTags.append(title)
            unSelectedTagListView.addTag(title)
        }
        else {
            unSelectedTagListView.removeTag(title)
            unselectedTags = selectedTags.filter{ $0 != title}
            selectedTags.append(title)
            selectedTagListView.addTag(title)
        }
    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        if sender == selectedTagListView {
            selectedTagListView.removeTag(title)
            selectedTags = selectedTags.filter{ $0 != title}
            unselectedTags.append(title)
            unSelectedTagListView.addTag(title)
        }
        else {
            unSelectedTagListView.removeTag(title)
            unselectedTags = selectedTags.filter{ $0 != title}
            selectedTags.append(title)
            selectedTagListView.addTag(title)
        }
    }
}
