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
    public static let apiUrl = "http://192.168.1.238:5000/api/";
    public static var token = ""
    
    static func login(param:[String:String], completion:((JSON)->Void)?) {
        post(url: "auth/login", param: param) { json in
            completion!(json)
        }
    }
    static func register(param:[String:String], completion:((JSON)->Void)?) {
        post(url: "auth/register", param: param) { json in
            completion!(json)
        }
    }
    static func setType(type:String, completion:((JSON)->Void)?) {
        post(url: "users/set-type", param: ["type":type]) { json in
            completion!(json)
        }
    }
    static func getProfile(completion:((JSON)->Void)?) {
        post(url: "users/profile", param: nil) { json in
            completion!(json)
        }
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
                    json["message"].string = error.localizedDescription
                    completion!(json)
                }
        }
    }
}
