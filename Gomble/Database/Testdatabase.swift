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
    public static var materialData = [JSON]()
    public static var measurementData = [JSON]()
    public static var patternData = [JSON]()
    public static var readyToWearData = [JSON]()
    public static var sizeRangeData = JSON()
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
}
