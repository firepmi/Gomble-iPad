//
//  CustomerTechpackPreviewViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/17/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import ImageSlideshow
import TagListView
import XLPagerTabStrip

class CustomerTechpackPreviewViewController: DefaultViewController {

    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var massProductionView: UIView!
    
    let localSource = [BundleImageSource(imageString: "test1.png"),BundleImageSource(imageString: "test2.png"),BundleImageSource(imageString: "test3.png"),BundleImageSource(imageString: "test4.png"),BundleImageSource(imageString: "test5.png")]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slideshow.setImageInputs(localSource)
        slideshow.delegate = self
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        tagListView.addTags(["summer","dress","dots"]);
        
        massProductionView.dropShadow(color: UIColor.black, opacity: 0.2, offSet: CGSize(width: -1,height: 1), radius: 10, scale: true)
        massProductionView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        
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
}
extension CustomerTechpackPreviewViewController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:",page)
    }
}
