//
//  ProductModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
struct FarmsModel: Decodable {
    
    struct Data: Decodable {
        let location: String?
        let name: String?
        let image: String?
        let ratings: String?
    }

    let farms: [Data]?
}
