//
//  HomePageLandscapeModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 6/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

enum FileName {
    case Farm, Vegetable, Fruit
    
    var file: String? {
        switch self {
        case .Farm:
            return "FarmsData.json"
        case .Vegetable:
            return "ProductsData.json"
        case .Fruit:
            return "ProductsData.json"
        }
    }
}

class HomeLandscapeModel {
    let name: String
    let file: FileName
    
    init(name: String, file: FileName) {
        self.name = name
        self.file = file
    }
}

let values = [
    HomeLandscapeModel(name: "Farms", file: .Farm),
    HomeLandscapeModel(name: "Vegetables", file: .Vegetable),
    HomeLandscapeModel(name: "Fruits", file: .Fruit)
]
