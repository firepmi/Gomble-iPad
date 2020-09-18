//
//  GeneralInfoView.swift
//  Gomble
//
//  Created by mobileworld on 8/21/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

@IBDesignable
class GeneralInfoView: BaseView {
    @IBOutlet weak var titleTextField: RoundedTextField!
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var descriptionTextView: RoundedTextView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    var delegate: UIViewController?
    let picker:UIImagePickerController?=UIImagePickerController()
    var tags = [String]()
    override func setNibName() {
        nibName = "GeneralInfoView"        
    }
    var isImageUpdated = false
    var generalInfoData = JSON()
    
    override func initView() {
        imageContentView.isHidden = true
        emptyView.isHidden = false
        picker?.delegate = self
        
        tags.append("dress")
        tagListView.addTags(tags);
        tagListView.delegate = self
        getData()
    }
    func getData(){
        var param = [String:String]()
        param["techpack_id"] = Globals.techpackID
        APIManager.getGeneralInfo(param: param) { (json) in
            print(json)
            if json["success"].boolValue {
                self.refreshView(json: json["res"])
            }
            else {
                print(json["message"].stringValue)
            }
        }
    }
    func refreshView(json:JSON){
        titleTextField.text = json["title"].stringValue
        descriptionTextView.text = json["description"].stringValue
        tags = []
        for tag in json["tags"].arrayValue {
            tags.append(tag.stringValue)
        }
        tagListView.removeAllTags()
        tagListView.addTags(tags)
        let imageUrl = APIManager.fullGeneralInfoImagePath(name: json["image"].stringValue)
        imageView.sd_setImage(with: URL(string: imageUrl)){ image, error, cache, urls in
            if error == nil {
                self.imageView.image = image
                self.emptyView.isHidden = true
                self.imageContentView.isHidden = false
            }
        }
    }
    func updateData(completion:((JSON)->Void)?){
        let multipartFormData = MultipartFormData()
        var tagStr = ""
        for tag in tags {
            tagStr = tagStr + tag + ","
        }
        if tagStr.count != 0 {
            tagStr = tagStr[0..<tagStr.count-1]
        }
        let title = titleTextField.text!
        let description = descriptionTextView.text!
        
        if title != "" {
            multipartFormData.append(title.data(using: .utf8, allowLossyConversion: false)!, withName: "title")
        }
        if description != "" {
            multipartFormData.append(description.data(using: .utf8, allowLossyConversion: false)!, withName: "description")
        }
        if tagStr != "" {
            multipartFormData.append(tagStr.data(using: .utf8, allowLossyConversion: false)!, withName: "tags")
        }
        multipartFormData.append(Globals.techpackID.data(using: .utf8, allowLossyConversion: false)!, withName: "techpack_id")
        if isImageUpdated {
            multipartFormData.append((imageView.image!.jpegData(compressionQuality: 1))!, withName: "image",fileName: "generalinfo.jpg", mimeType: "image/jpg")
        }
        APIManager.updateGeneralInfo(param: multipartFormData, uploadProgress: { progress in
            print(progress)
        }, completion: completion)
    }
    @IBAction func onUploadImage(_ sender: Any) {
        var alert = UIAlertController(title:"Select image from...", message:nil, preferredStyle: .actionSheet)
        
        if alert.popoverPresentationController != nil {
            alert = UIAlertController(title:"Select image from...", message:nil, preferredStyle: .alert)
        }
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        delegate!.present(alert, animated: true, completion: nil)
    }
    @IBAction func onEditImage(_ sender: Any) {
        onUploadImage(sender)
    }
    @IBAction func onDeleteImage(_ sender: Any) {
        imageView.image = nil
        emptyView.isHidden = false
        imageContentView.isHidden = true
        isImageUpdated = false
    }
}

extension GeneralInfoView: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropperViewDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        print("Image picked")
        picker.dismiss(animated: true, completion: nil)
        let chosenImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        CropperViewController.image = chosenImage
        showCropperDialog(image: chosenImage!)
    }
    func showCropperDialog(image: UIImage){
        let vc = delegate?.storyboard!.instantiateViewController(withIdentifier: "cropperViewController") as! CropperViewController
        
        vc.modalPresentationStyle = .overFullScreen
        let popover = vc.popoverPresentationController
        popover?.sourceView = delegate!.view
        popover?.sourceRect = delegate!.view.bounds
        popover?.delegate = self as? UIPopoverPresentationControllerDelegate
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.delegate!.present(vc, animated: true, completion:nil)
        })
    }
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        delegate!.present(picker!, animated: true, completion: nil)
        //        ProfileViewController.state = "gallery"
    }
    func onCroppedImage(image:UIImage){
        print("cropped")
        imageView.image = image
        emptyView.isHidden = true
        imageContentView.isHidden = false
        isImageUpdated = true
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker!.cameraCaptureMode = .photo
            delegate!.present(picker!, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            delegate!.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate!.dismiss(animated: true, completion: nil)
    }
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}
extension GeneralInfoView: TagListViewDelegate {
    func tagAddedPressed(_ title: String, sender: TagListView) {
        tagListView.addTag(title)
        tags.append(title)
    }
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title)
        tags = tags.filter{ $0 != title}
    }
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        tagListView.removeTag(title)
        tags = tags.filter{ $0 != title}
    }
}
