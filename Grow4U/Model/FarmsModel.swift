//
//  ProductModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
struct FarmsModel: Decodable {
    struct Data: Decodable {
        let locations: [String]?
        let type: String?
        let name: String?
        let img_url: String?
        let rating: String?
        let contact: String?
        let currency: String?
        let products: [products_info]?
    }
    let farm: [Data]
    struct products_info: Decodable {
        let id: String?
        let offered_price: String?
    }
}

//
//import Foundation
//class Farms: Codable {
//    let farms: [FarmsModel]
//    init(farms: [FarmsModel]) {
//        self.farms = farms
//    }
//}
//
//class SearchResultModel: Codable {
//    let id : String
//    let img_url: String
//    let name: String
//    let price: String
//    let unit: String
//    let currency: String
//    let description: String
//
//    init(id : String, img_url: String, productName: String, productPrice: String, unit: String, currency: String, description: String) {
//        self.id = id
//        self.img_url = img_url
//        self.name = productName
//        self.price = productPrice
//        self.unit = unit
//        self.currency = currency
//        self.description = description
//    }
//
//}
