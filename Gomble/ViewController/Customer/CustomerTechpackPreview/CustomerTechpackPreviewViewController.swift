//
//  CustomerTechpackPreviewViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/17/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import ImageSlideshow
import XLPagerTabStrip
import SDWebImage
import JGProgressHUD
import SwiftyJSON

class CustomerTechpackPreviewViewController: BaseViewController {

    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var massProductionView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var designerProfileImageView: RoundedImageView!
    @IBOutlet weak var designerNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var generalInfo = JSON()
    var designer = JSON()
    var localSource = [SDWebImageSource]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slideshow.delegate = self
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        massProductionView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
        massProductionView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.getGeneralInfo(param: param) { json in
            hud.dismiss()
            if json["success"].boolValue {
                self.generalInfo = json["res"]
                self.refreshViewGeneralInfo()
            }
            else {
                Globals.alert(context: self, title: "Preview Techpack", message: json["message"].stringValue)
            }
        }
        
        APIManager.getTechpackDesigner(param: param) { json in
            if json["success"].boolValue {
                self.designer = json["res",0]
                self.refreshDesigner()
            }
            else {
                Globals.alert(context: self, title: "Preview Techpack", message: json["message"].stringValue)
            }
        }
    }
    func refreshViewGeneralInfo(){
        if generalInfo["title"].string != nil {
            titleLabel.text = generalInfo["title"].stringValue
            title2Label.text = generalInfo["title"].stringValue
            descriptionLabel.text = generalInfo["description"].stringValue
            localSource.removeAll()
            localSource.append(SDWebImageSource(urlString: APIManager.fullGeneralInfoImagePath(name: generalInfo["image"].stringValue))!)
            slideshow.setImageInputs(localSource)
            tagListView.removeAllTags()
            for tag in generalInfo["tags"].arrayValue{
                tagListView.addTag(tag.stringValue)
            }
        }
    }
    func refreshDesigner() {
        if designer["first_name"].string != nil {
            designerNameLabel.text = designer["first_name"].stringValue + " " + designer["last_name"].stringValue
            let imageUrl = APIManager.fullUserImagePath(name: designer["image"].stringValue)
            designerProfileImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "profile-anonymous.jpg"))
        }
    }
    @IBAction func onPreviousImage(_ sender: Any) {
        slideshow.previousPage(animated: true)
    }
    
    @IBAction func onNextImage(_ sender: Any) {
        slideshow.nextPage(animated: true)
    }
    
    @IBAction func onFullScreenImage(_ sender: Any) {
        slideshow.presentFullScreenController(from: self)
    }
    
    @IBAction func onMakeOrder(_ sender: Any) {
        
    }
}
extension CustomerTechpackPreviewViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:",page)
    }
}
