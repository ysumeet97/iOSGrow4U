//
//  ProductModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
struct ProductDataModel: Decodable {
    
    struct Data: Decodable {
        let location: String?
        let vegetables: [Product]?
        let fruits: [Product]?
    }
    struct Product: Decodable {
        let type: String?
        let price: String?
        let image: String?
        let maxQuantity: String?
        let availability: String?
    }
    let locations: [Data]?
}
