//
//  MaterialGeneralInfoView.swift
//  Gomble
//
//  Created by mobileworld on 8/25/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit

@IBDesignable
class MaterialGeneralInfoView: DefaultView {
    @IBOutlet weak var titleTextField: RoundedTextField!
    @IBOutlet weak var placementTextField: RoundedTextField!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var descriptionTextView: RoundedTextView!
    
    var tags = [String]()
    override func setNibName() {
        nibName = "MaterialGeneralInfoView"
    }
    override func initView() {        
        tags.append("dress")
        tagListView.addTags(tags);
        tagListView.delegate = self
    }
    
}

extension MaterialGeneralInfoView: TagListViewDelegate {
    func tagAddedPressed(_ title: String, sender: TagListView) {
        tagListView.addTag(title)
    }
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title)
    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title)
    }
}
