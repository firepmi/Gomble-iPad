//
//  AddItemImageSelectView.swift
//  Gomble
//
//  Created by mobileworld on 8/24/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

@IBDesignable
class AddItemImageSelectView: BaseView {
    
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var emptyView: UIView!
    
    var delegate: UIViewController?
    let picker:UIImagePickerController?=UIImagePickerController()
    var isImageUpdated = false
    
    override func setNibName() {
        nibName = "AddItemImageSelectView"
    }
    override func initView() {
        picker?.delegate = self
    }
    
    @IBAction func onAddPhoto(_ sender: Any) {
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
}
extension AddItemImageSelectView: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropperViewDelegate {
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
