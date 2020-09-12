//
//  APIManager.swift
//  Gomble
//
//  Created by mobileworld on 9/2/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APIManager {
    public static let rootUrl = "http://192.168.1.238:5000/"
//    public static let rootUrl = "http://18.219.54.224:5000/"
    public static let apiUrl = "\(rootUrl)api/"
    public static let imageUrl = "\(rootUrl)public/uploads/"
    public static var token = ""
    
    static func saveToken(){
        if token != "" {
            UserDefaults.standard.set(token, forKey: "token")
        }
    }
    static func loadToken() -> Bool {
        if UserDefaults.standard.string(forKey: "token") != nil {
            token = UserDefaults.standard.string(forKey: "token")!
            return true
        }
        return false
    }
    static func clearToken() {
        UserDefaults.standard.set("", forKey: "token")
    }
    static func fullUserImagePath(name:String) -> String {
        return "\(imageUrl)users/\(name)"
    }
    
    static func login(param:[String:String], completion:((JSON)->Void)?) {
        post(url: "auth/login", param: param, completion: completion)
    }
    static func register(param:[String:String], completion:((JSON)->Void)?) {
        post(url: "auth/register", param: param, completion: completion)
    }
    static func setType(type:String, completion:((JSON)->Void)?) {
        post(url: "users/set-type", param: ["type":type], completion: completion)
    }
    static func getProfile(completion:((JSON)->Void)?) {
        post(url: "users/profile", param: nil, completion: completion)
    }
    static func basicProfile(completion:((JSON)->Void)?) {
        post(url: "users/basic-profile", param: nil, completion: completion)
    }
    static func type(completion:((JSON)->Void)?) {
        post(url: "users/type", param: nil, completion: completion)
    }
    static func updateProfile(param:[String:String], completion:((JSON)->Void)?) {
        post(url: "users/update-profile", param: param, completion: completion)
    }
    static func updateProfile(param:MultipartFormData, uploadProgress: ((Double)->Void)?, completion:((JSON)->Void)?) {
        multipartPost(url: "users/update-profile", param: param, uploadProgress: uploadProgress, completion: completion)
    }
    static func fbLogin(param:[String:String], completion:((JSON)->Void)?) {
        post(url: "auth/fblogin", param: param, completion: completion)
    }
    static func applelogin(param:[String:String], completion:((JSON)->Void)?) {
        post(url: "auth/applelogin", param: param, completion: completion)
    }
    static func getFolders(completion:((JSON)->Void)?) {
        post(url: "folders", param: nil, completion: completion)
    }
    static func createFolder(param:[String:String],completion:((JSON)->Void)?) {
        post(url: "folders/create", param: param, completion: completion)
    }
    static func getTechpacks(param:[String:String],completion:((JSON)->Void)?) {
        post(url: "techpacks", param: param, completion: completion)
    }
    static func getDraft(param:[String:String],completion:((JSON)->Void)?) {
        post(url: "techpacks/draft", param: param, completion: completion)
    }
    static func updateStage(param:[String:String],completion:((JSON)->Void)?) {
        post(url: "stage/update", param: param, completion: completion)
    }
    static func updateGeneralInfo(param:MultipartFormData, uploadProgress: ((Double)->Void)?, completion:((JSON)->Void)?) {
        multipartPost(url: "generalinfo/update", param: param, uploadProgress: uploadProgress, completion: completion)
    }
    static func updatePrice(param:[String:String],completion:((JSON)->Void)?) {
        post(url: "price/update", param: param, completion: completion)
    }
    static func getPrice(param:[String:String],completion:((JSON)->Void)?) {
        post(url: "price", param: param, completion: completion)
    }
    static func addSketch(param:MultipartFormData, uploadProgress: ((Double)->Void)?, completion:((JSON)->Void)?) {
        multipartPost(url: "sketch/add", param: param, uploadProgress: uploadProgress, completion: completion)
    }
    static func getSketches(param:[String:String],completion:((JSON)->Void)?) {
        post(url: "sketch", param: param, completion: completion)
    }
    static func publishTechpack(param:[String:String],completion:((JSON)->Void)?) {
        post(url: "techpacks/publish", param: param, completion: completion)
    }
    
    static func post(url: String, param:[String:String]?, completion:((JSON)->Void)?) {
        let link = apiUrl + url
        print(link)
        AF.request(link, method: .post, parameters: param,encoding: JSONEncoding.default, headers: [
        "Authorization":token])
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    completion!(json)
                case .failure(let error):
                    print(error.localizedDescription)
                    var json = JSON()
                    json["success"].bool = false
                    if error.localizedDescription == "URLSessionTask failed with error: unsupported URL" {
                        json["message"].string = "Please check your network and try again"
                    }
                    else {
                        json["message"].string = error.localizedDescription
                    }
                    completion!(json)
                }
        }
    }

    static func multipartPost(url: String, param:MultipartFormData, uploadProgress: ((Double)->Void)?, completion:((JSON)->Void)?) {
        let link = apiUrl + url
        print(link)
        URLSessionConfiguration.default.timeoutIntervalForRequest = 600
        URLSessionConfiguration.default.timeoutIntervalForResource = 600
        
        AF.upload(multipartFormData: param, to: link, method: .post, headers: ["Authorization":token])
            .uploadProgress(queue: .main) { progress in
            print("\(progress.fractionCompleted)")
                uploadProgress!(progress.fractionCompleted)
        }.response { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value!)
                completion!(json)
            case .failure(let error):
                print(error.localizedDescription)
                var json = JSON()
                json["success"].bool = false
                if error.localizedDescription == "URLSessionTask failed with error: unsupported URL" {
                    json["message"].string = "Please check your network and try again"
                }
                else {
                    json["message"].string = error.localizedDescription
                }
                completion!(json)
            }
        }
    }
}
