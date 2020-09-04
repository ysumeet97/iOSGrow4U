//
//  SearchResultModel.swift
//  Grow4U
//
//  Created by Sainath Reddy K on 3/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
class SearchResults: Codable {
    let products: [SearchResultModel]
    init(products: [SearchResultModel]) {
        self.products = products
    }
}

class SearchResultModel: Codable {
    let id : String
    let img_url: String
    let name: String
    let price: String
    let unit: String
    let currency: String
    
    init(id : String, img_url: String, productName: String, productPrice: String, unit: String, currency: String) {
        self.id = id
        self.img_url = img_url
        self.name = productName
        self.price = productPrice
        self.unit = unit
        self.currency = currency
    }
    
}
