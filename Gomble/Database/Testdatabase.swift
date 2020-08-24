//
//  Testdatabase.swift
//  Gomble
//
//  Created by mobileworld on 8/20/20.
//  Copyright © 2020 Haley Huynh. All rights reserved.
//

import UIKit
import SwiftyJSON

class Testdatabase {
    public static var folders = [JSON]()
    public static var techpacks = [JSON]()
    public static let techPackData = [
        ["title":"Summer dress collection", "image":"test1.png"],
        ["title":"Elegant gray dress", "image":"test2.png"],
        ["title":"Coral cotton dress", "image":"test3.png"],
        ["title":"Summer dress collection with dot", "image":"test4.png"],
        ["title":"Summer dress collection with flowers", "image":"test5.png"]
    ]
    public static func getTestColaborationData() -> [JSON]{
        var json1 = JSON()
        json1["first_name"].string = "John"
        json1["last_name"].string = "Doe"
        json1["email"].string = "john.doe@email.com"
        var json2 = JSON()
        json2["first_name"].string = "John"
        json2["last_name"].string = "Doe"
        json2["email"].string = "john.doe@email.com"
        var json3 = JSON()
        json3["first_name"].string = "John"
        json3["last_name"].string = "Doe"
        json3["email"].string = "john.doe@email.com"
        return [json1,json2,json3,]
    }
    public static func getTestSketchData() -> [JSON]{
        var json1 = JSON()
        json1["title"].string = "Front"
        json1["tag"].arrayObject = ["dress","front"]
        json1["description"].string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus egestas risus, ultrices faucibus adipiscing in morbi lorem ipsum dolor"
        var json2 = JSON()
        json2["title"].string = "Back"
        json2["tag"].arrayObject = ["dress","back"]
        json2["description"].string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lacus egestas risus, ultrices faucibus adipiscing in morbi lorem ipsum dolor"
        
        return [json1,json2,]
    }
}
