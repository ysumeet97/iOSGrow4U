//
//  ImageCategory.swift
//  Grow4U
//
//  Created by vaishali wahi on 5/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
import Foundation

struct CategoryConstants {
    static let category_ID = "prod_id"
    static let category_Description = "prod_description"
    static let category_Name = "prod_name"
    static let category_Items = "prod_items"
}


class ImageCategory {
    let name:String
    let prodId:String
    let prodDescription:[String]
    var prodItems:[String] //this will holds the
    init(withInfo infoDict:[String:Any]) {
        self.name = infoDict[CategoryConstants.category_Name] as! String
        self.prodId = infoDict[CategoryConstants.category_ID] as! String
        self.prodDescription = infoDict[CategoryConstants.category_Description] as! [String]
        self.prodItems = infoDict[CategoryConstants.category_Items] as! [String]
    }
}

