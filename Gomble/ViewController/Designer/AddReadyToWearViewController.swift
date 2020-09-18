//
//  AddReadyToWearViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/27/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON
import JGProgressHUD
import Alamofire

class AddReadyToWearViewController: BaseDialogViewController {
    @IBOutlet weak var addButtonView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleTextField: RoundedTextField!
    @IBOutlet weak var descriptionTextView: RoundedTextView!
    
    let picker:UIImagePickerController?=UIImagePickerController()
    var isImageUpdated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
        
        present(alert, animated: true, completion: nil)
    }
    @IBAction func onAddMeasurement(_ sender: Any) {
        if titleTextField.text == "" {
            titleTextField.borderColor = UIColor.red
            return
        }
        else {
            titleTextField.borderColor = UIColor.init(hexString:"#D7E1EC")
        }
        
        let multipartFormData = MultipartFormData()
        
        let title = titleTextField.text!
        let description = descriptionTextView.text!
        
        if title != "" {
            multipartFormData.append(title.data(using: .utf8, allowLossyConversion: false)!, withName: "title")
        }
        if description != "" {
            multipartFormData.append(description.data(using: .utf8, allowLossyConversion: false)!, withName: "description")
        }
        multipartFormData.append(Globals.techpackID.data(using: .utf8, allowLossyConversion: false)!, withName: "techpack_id")
        if isImageUpdated {
            multipartFormData.append((imageView.image!.jpegData(compressionQuality: 1))!, withName: "image",fileName: "generalinfo.jpg", mimeType: "image/jpg")
        }
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)
        APIManager.addReadyToWear(param: multipartFormData, uploadProgress: { progress in
            print(progress)
        }) { json in
            hud.dismiss()
            if json["success"].boolValue {
                print(json["message"].stringValue)
                self.completion?()
                self.dismiss(animated: true, completion: nil)
            }
            else {
                self.view.makeToast(json["message"].stringValue)
            }
        }
        
    }
}
extension AddReadyToWearViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            descriptionTextView.becomeFirstResponder()
        }
        else {
            dismissKeyboard()
        }
        return true
    }
  
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension AddReadyToWearViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, CropperViewDelegate {
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
        addButtonView.isHidden = true
        isImageUpdated = true
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



