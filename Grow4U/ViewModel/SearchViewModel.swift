//
//  SearchViewModel.swift
//  Grow4U
//
//  Created by Sainath Reddy K on 4/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation

class SearchViewModel {
    private var searcResultModel:  SearchResultModel?
    private var fileName : (products: String, farmers: String)
    private var jsonProducts =  [SearchResultModel]()
    private var jsonFarmers =  [FarmsModel.Data]()
    
    init(fileName: (products: String, farmers: String)) {
        self.fileName.products = fileName.products
        self.fileName.farmers = fileName.farmers
        loadJsonData()
    }
    
    private func loadJsonData() {
        guard let productspath = Bundle.main.path(forResource: fileName.products, ofType: "json") else { return }
        guard let farmerspath = Bundle.main.path(forResource: fileName.farmers, ofType: "json") else { return }
        let url1 = URL(fileURLWithPath: productspath)
        let url2 = URL(fileURLWithPath: farmerspath)
        do {
            let productData = try Data(contentsOf: url1)
            let farmersData = try Data(contentsOf: url2)
            self.jsonProducts = try JSONDecoder().decode(SearchResults.self, from: productData).products
            self.jsonFarmers = try  JSONDecoder().decode(FarmsModel.self, from: farmersData).farm
        } catch  {
            print(error)
        }
    }
    
    public func getJsonData() -> (products: [SearchResultModel], farms: [FarmsModel.Data]){
        return (products: self.jsonProducts, farms: self.jsonFarmers)
    }    
}
