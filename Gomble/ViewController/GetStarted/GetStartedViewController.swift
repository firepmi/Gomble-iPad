//
//  GetStartedViewController.swift
//  Gomble
//
//  Created by mobileworld on 8/11/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FBSDKLoginKit
import SwiftyJSON
import JGProgressHUD
import AuthenticationServices

class GetStartedViewController: ButtonBarPagerTabStripViewController {
    
    let labelColor = UIColor.white
       
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = labelColor
        settings.style.buttonBarItemFont = UIFont(name: "Gilroy-ExtraBold", size: 20)!
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0

        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
//            oldCell?.label.textColor = self?.labelColor
//            oldCell?.label.font = UIFont(name: "Gilroy-ExtraBold", size: 20)!
//            newCell?.label.textColor = .black
//            newCell?.label.font = UIFont(name: "Gilroy-ExtraBold", size: 20)!
//            newCell?.backgroundView?.backgroundColor = UIColor.clear
        }
        super.viewDidLoad()
        
//        for family in UIFont.familyNames.sorted() {
//            let names = UIFont.fontNames(forFamilyName: family)
//            print("Family: \(family) Font names: \(names)")
//        }
    }
    // MARK: - PagerTabStripDataSource

    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let signin = storyboard!.instantiateViewController(withIdentifier: "signin")
        let signup = storyboard!.instantiateViewController(withIdentifier: "signup")
        return [signin, signup]
    }
    @IBAction func onFBLogin(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [ "public_profile", "email" ], from: self) { loginResult, error in
            if error != nil {
                print(error.debugDescription)
            }
            else {
                GraphRequest(graphPath: "/me", parameters: ["fields": "email, id, first_name, last_name, picture.type(large)"]).start {
                    (connection, result, err) in
                    if(err == nil) {
                        var json = JSON(result!)
                        json["token"].string = AccessToken.current!.tokenString
                        print(json)
                        self.onFBLoginRequest(json: json)
                    }
                    else
                    {
                        print(err.debugDescription)
                    }
                }
            }
            
        }
    }
    func onFBLoginRequest(json:JSON){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Please wait..."
        hud.show(in: self.view)

        let params:[String:String] = [
            "email":json["email"].stringValue,
            "first_name":json["first_name"].stringValue,
            "last_name":json["last_name"].stringValue,
            "id":json["id"].stringValue,
            "accessToken":json["token"].stringValue,
            "image":json["picture"]["data"]["url"].stringValue
        ]
        APIManager.fbLogin(param: params) { json in
            hud.dismiss()
            if json["success"].boolValue {
                APIManager.token = json["token"].stringValue
                
                var vc_id = "select_type"
                if json["type"].stringValue != "-" {
                    vc_id = json["type"].stringValue + "_home"
                }
                self.goToVC(id: vc_id)
            }
            else {
                Globals.alert(context: self, title: "Sign In", message: json["message"].stringValue)
            }
        }
    }
    func goToVC(id:String) {
        let customer = storyboard!.instantiateViewController(withIdentifier: id)
        customer.modalPresentationStyle = .fullScreen
        present(customer, animated: true, completion: nil)
    }
    @IBAction func onAppleLogin(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
            Globals.alert(context: self, title: "Apple login", message: "Apple login is only available for iOS 13 or later")
        }
    }
}
@available(iOS 13.0, *)
extension GetStartedViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            if email == nil {
                Globals.alert(context: self, title: "Apple login", message: "email is required, please share your email")
                return
            }
            var param = [String:String]()
            param["email"] = email
            param["first_name"] = fullName?.givenName
            param["last_name"] = fullName?.familyName
            param["id"] = userIdentifier
            APIManager.applelogin(param: param) { json in
                if json["success"].boolValue {
                    APIManager.token = json["token"].stringValue
                    
                    var vc_id = "select_type"
                    if json["type"].stringValue != "-" {
                        vc_id = json["type"].stringValue + "_home"
                    }
                    self.goToVC(id: vc_id)
                }
                else {
                    Globals.alert(context: self, title: "Apple login", message: json["message"].stringValue)
                }
            }
        }
        else {
            Globals.alert(context: self, title: "Apple login", message: "Could not get apple id credential")
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}
