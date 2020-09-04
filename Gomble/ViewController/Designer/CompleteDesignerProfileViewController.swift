//
//  CompleteDesignerProfileViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/19/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import JGProgressHUD

class CompleteDesignerProfileViewController: BaseDialogViewController {
    let picker:UIImagePickerController?=UIImagePickerController()
    
    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var nickNameTextField: RoundedTextField!
    @IBOutlet weak var firstNameTextField: RoundedTextField!
    @IBOutlet weak var lastNameTextField: RoundedTextField!
    @IBOutlet weak var descriptionTextView: RoundedTextView!
    @IBOutlet weak var websiteTextField: RoundedTextField!
    @IBOutlet weak var phoneTextField: RoundedTextField!
    var isProfileImageUpdated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        picker?.delegate = self
    }
    @IBAction func onCamera(_ sender: Any) {
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
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onNext(_ sender: Any) {
        if firstNameTextField.text == "" {
            firstNameTextField.borderColor = UIColor.red
            return
        }
        else {
            firstNameTextField.borderColor = UIColor.init(hexString:"#D7E1EC")
        }
        if lastNameTextField.text == "" {
            lastNameTextField.borderColor = UIColor.red
            return
        }
        else {
            lastNameTextField.borderColor = UIColor.init(hexString:"#D7E1EC")
        }
        if !isProfileImageUpdated {
            Globals.alert(context: self, title: "Complete your profile", message: "Please upload your profile image")
            return
        }
        let nickname = nickNameTextField.text!
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let description = descriptionTextView.text!
        let website = websiteTextField.text!
        let phone = phoneTextField.text!
        
        let multipartFormData = MultipartFormData()
        if nickname != "" {
            multipartFormData.append(nickname.data(using: .utf8, allowLossyConversion: false)!, withName: "nickname")
        }
        if firstName != "" {
            multipartFormData.append(firstName.data(using: .utf8, allowLossyConversion: false)!, withName: "first_name")
        }
        if lastName != "" {
            multipartFormData.append(lastName.data(using: .utf8, allowLossyConversion: false)!, withName: "last_name")
        }
        if description != "" {
            multipartFormData.append(description.data(using: .utf8, allowLossyConversion: false)!, withName: "description")
        }
        if website != "" {
            multipartFormData.append(website.data(using: .utf8, allowLossyConversion: false)!, withName: "website")
        }
        if phone != "" {
            multipartFormData.append(phone.data(using: .utf8, allowLossyConversion: false)!, withName: "phone")
        }
        if isProfileImageUpdated {
            multipartFormData.append((imageView.image!.jpegData(compressionQuality: 1))!, withName: "image",fileName: "userprofile.jpg", mimeType: "image/jpg")
        }
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading..."
        hud.indicatorView = JGProgressHUDPieIndicatorView()
        hud.show(in: self.view)
        APIManager.updateProfile(param: multipartFormData, uploadProgress: { progress in
            hud.progress = Float(progress)
        }) { json in
            hud.dismiss()
            print(json)
            if json["success"].boolValue {
                self.completion?()
                self.dismiss(animated: true, completion: nil)
            }
            else {
                Globals.alert(context: self, title: "Complete Profile", message: json["message"].stringValue)
            }
        }
    }
    @IBAction func onSkip(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CompleteDesignerProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropperViewDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        print("Image picked")
        picker.dismiss(animated: true, completion: nil)
        let chosenImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        CropperViewController.image = chosenImage
        showCropperDialog(image: chosenImage!)
    }
    func showCropperDialog(image: UIImage){
        let vc = storyboard!.instantiateViewController(withIdentifier: "cropperViewController") as! CropperViewController
        
        vc.modalPresentationStyle = .overFullScreen
        let popover = vc.popoverPresentationController
        popover?.sourceView = view
        popover?.sourceRect = view.bounds
        popover?.delegate = self as? UIPopoverPresentationControllerDelegate
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.present(vc, animated: true, completion:nil)
        })
    }
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
        //        ProfileViewController.state = "gallery"
    }
    func onCroppedImage(image:UIImage){
        print("cropped")
        imageView.image = image
        isProfileImageUpdated = true
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerController.SourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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

