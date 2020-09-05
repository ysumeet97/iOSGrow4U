//
//  SearchViewModel.swift
//  Grow4U
//
//  Created by Sainath Reddy K on 4/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation

class SearchViewModel {
    private var searcResulthModel:  SearchResultModel?
    private var fileName : String?
    private var jsonProducts =  [SearchResultModel]()
    
    init(fileName: String) {
        self.fileName = fileName
        loadJsonData()
    }
    
    private func loadJsonData() {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let productData = try Data(contentsOf: url)
            self.jsonProducts  = try
                JSONDecoder().decode(SearchResults.self, from: productData).products
        } catch  {
            print(error)
        }
    }
    
    public func getJsonData() -> [SearchResultModel]{
        return self.jsonProducts
    }    
}
