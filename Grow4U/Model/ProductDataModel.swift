//
//  ProductModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
struct ProductDataModel: Decodable {
    
    struct Data: Decodable {
        let id: String?
        let img_url: String?
        let type: String?
        let name: String?
        let availability: String?
        let max_quantity: String?
        let description: String?
        let price: String?
        let unit: String?
        let currency: String?
        let locations: [String?]
        let farmers: [String?]
    }
    let products: [Data]?
}
