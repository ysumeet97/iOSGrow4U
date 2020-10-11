//
//  ImageCategory.swift
//  Grow4U
//
//  Created by vaishali wahi on 5/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
import Foundation

struct CategoryConstants {
    static let category_ID = "prod_ID"
    static let category_Index = "prod_index"
    static let category_Type = "prod_type"
    static let category_Description = "prod_description"
    static let category_Name = "prod_name"
    static let category_Items = "prod_items"
}


class ImageCategory {
    let prod_ID: [String]
    let name:[String]
    let type:String
    let prodIndex:String
    let prodDescription:[String]
    var prodItems:[String] //this will holds the
    init(withInfo infoDict:[String:Any]) {
        self.prod_ID = infoDict[CategoryConstants.category_ID] as! [String]
        self.name = infoDict[CategoryConstants.category_Name] as! [String]
        self.type = infoDict[CategoryConstants.category_Type] as! String
        self.prodIndex = infoDict[CategoryConstants.category_Index] as! String
        self.prodDescription = infoDict[CategoryConstants.category_Description] as! [String]
        self.prodItems = infoDict[CategoryConstants.category_Items] as! [String]
    }
}

