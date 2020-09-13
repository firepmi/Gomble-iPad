//
//  DefaultProfileViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/16/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import Alamofire
import JGProgressHUD

class BaseProfileViewController: BaseViewController {

    @IBOutlet weak var profileImageView: RoundedImageView!
    @IBOutlet weak var typeLabel: RoundedLabel!
    @IBOutlet weak var firstNameTextField: RoundedTextField!
    @IBOutlet weak var lastNameTextField: RoundedTextField!
    @IBOutlet weak var emailTextField: RoundedTextField!
    @IBOutlet weak var streetTextField: RoundedTextField!
    @IBOutlet weak var numberTextField: RoundedTextField!
    @IBOutlet weak var aptTextField: RoundedTextField!
    @IBOutlet weak var cityTextField: RoundedTextField!
    @IBOutlet weak var countryTextField: RoundedTextField!
    @IBOutlet weak var zipTextField: RoundedTextField!
    @IBOutlet weak var phoneTextField: RoundedTextField!
    
    let picker:UIImagePickerController?=UIImagePickerController()
    var isProfileImageUpdated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker?.delegate = self
        getData()
    }
    func getData(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        APIManager.getProfile { json in
            print(json)
            hud.dismiss()
            if json["success"].boolValue {
                if json["res","first_name"].string == nil && Globals.type == "designer" {
                    self.openDialog(id: "complete_profile_designer") {
                        self.getData()
                    }
                }
                self.loadData(json: json["res"])
            }
        }
    }
    func loadData(json:JSON){
        if Globals.type == "designer" {
            typeLabel.text = "Fashion Designer"
        }
        else {
            typeLabel.text = "Customer"
        }
        emailTextField.text = json["email"].stringValue
        firstNameTextField.text = json["first_name"].string
        lastNameTextField.text = json["last_name"].string
        streetTextField.text = json["street"].string
        numberTextField.text = json["street_number"].string
        aptTextField.text = json["apt"].string
        cityTextField.text = json["city"].string
        countryTextField.text = json["country"].string
        zipTextField.text = json["zip"].string
        phoneTextField.text = json["phone"].string
        if json["image"].string != nil {
            let imageUrl = "\(APIManager.imageUrl)users/\(json["image"].string!)"
            print(imageUrl)
            profileImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "profile-anonymous.jpg"))
        }
    }
    override func onProfileClicked() {
        print("printed profile")
    }
    @IBAction func onProfileImage(_ sender: Any) {
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
    @IBAction func onDeleteAccount(_ sender: Any) {
    }
    @IBAction func onChangePassword(_ sender: Any) {
    }
    @IBAction func onLogOut(_ sender: Any) {
        APIManager.clearToken()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSave(_ sender: Any) {
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
//        if !isProfileImageUpdated {
//            Globals.alert(context: self, title: "Complete your profile", message: "Please upload your profile image")
//            return
//        }
        let email = emailTextField.text!
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let street = streetTextField.text!
        let streetNumber = numberTextField.text!
        let apt = aptTextField.text!
        let city = cityTextField.text!
        let country = countryTextField.text!
        let zip = zipTextField.text!
        let phone = phoneTextField.text!
        
        let multipartFormData = MultipartFormData()
        if email != "" {
            multipartFormData.append(email.data(using: .utf8, allowLossyConversion: false)!, withName: "email")
        }
        if firstName != "" {
            multipartFormData.append(firstName.data(using: .utf8, allowLossyConversion: false)!, withName: "first_name")
        }
        if lastName != "" {
            multipartFormData.append(lastName.data(using: .utf8, allowLossyConversion: false)!, withName: "last_name")
        }
        if street != "" {
            multipartFormData.append(street.data(using: .utf8, allowLossyConversion: false)!, withName: "street")
        }
        if streetNumber != "" {
            multipartFormData.append(streetNumber.data(using: .utf8, allowLossyConversion: false)!, withName: "street_number")
        }
        if apt != "" {
            multipartFormData.append(apt.data(using: .utf8, allowLossyConversion: false)!, withName: "apt")
        }
        if city != "" {
            multipartFormData.append(city.data(using: .utf8, allowLossyConversion: false)!, withName: "city")
        }
        if country != "" {
            multipartFormData.append(country.data(using: .utf8, allowLossyConversion: false)!, withName: "country")
        }
        if zip != "" {
            multipartFormData.append(zip.data(using: .utf8, allowLossyConversion: false)!, withName: "zip")
        }
        if phone != "" {
            multipartFormData.append(phone.data(using: .utf8, allowLossyConversion: false)!, withName: "phone")
        }
        if isProfileImageUpdated {
            multipartFormData.append((profileImageView.image!.jpegData(compressionQuality: 1))!, withName: "image",fileName: "userprofile.jpg", mimeType: "image/jpg")
            SDImageCache.shared.clearMemory()
            SDImageCache.shared.clearDisk()
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
                self.onBack()
            }
            else {
                Globals.alert(context: self, title: "Profile", message: json["message"].stringValue)
            }
        }
    }
    @IBAction func onCancel(_ sender: Any) {
        onBack()
    }
}

extension BaseProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropperViewDelegate {
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
        profileImageView.image = image
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

