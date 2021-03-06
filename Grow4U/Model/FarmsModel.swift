//
//  ProductModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
struct FarmsModel: Decodable {
    struct Data: Decodable {
        let id: String?
        let locations: [String]?
        let type: String?
        let name: String?
        let img_url: String?
        let rating: String?
        let contact: String?
        let currency: String?
        let products: [products_info]?
    }
    let farm: [Data]?
    struct products_info: Decodable {
        let id: String?
        let offered_price: String?
    }
}
