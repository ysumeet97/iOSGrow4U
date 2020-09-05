//
//  ProductInfoModel.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 3/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//


import Foundation

class ProductInfoModel: Decodable {
    struct Data: Decodable {
        var product_id: String?
        var product_name: String?
        var product_type: String?
        var product_price: String?
        var product_info: String?
    }
    let products:[Data]?
    //var product_image: String
}
