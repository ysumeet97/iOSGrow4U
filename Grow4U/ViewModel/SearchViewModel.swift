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
    var jsonProducts =  [SearchResultModel]()
    var jsonFarmers =  [FarmsModel.Data]()
    private final let prodUrl = URL (string: "https://api.jsonbin.io/b/5f82ee18302a837e9578059e")
    private final let farmUrl = URL (string: "https://api.jsonbin.io/b/5f82f1b0302a837e957807eb")
    
    
    init() {
        loadJsonData()
    }
    
    // This method is used to load the json data from the file
    func loadJsonData() {
        self.downloadJson(url: prodUrl!, isProduct: true)
        self.downloadJson(url: farmUrl!, isProduct: false)
    }
    
    func downloadJson(url: URL?, isProduct:Bool){
        guard let downloadURL = url else {
            return
        }
        URLSession.shared.dataTask(with: downloadURL){ data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else  {
                print("error in data transfer")
                return
            }
            do {
                if (isProduct) {
                    self.jsonProducts = try JSONDecoder().decode(SearchResults.self, from: data).products
                } else {
                    self.jsonFarmers = try  JSONDecoder().decode(FarmsModel.self, from: data).farm!
                }
            } catch {
                print("decode error: \(error)")
            }
            }.resume()
    }
    
    
    
    // This method is returns the product and farm data
    public func getJsonData() -> (products: [SearchResultModel], farms: [FarmsModel.Data]){
        return (products: self.jsonProducts, farms: self.jsonFarmers)
    }
}
