//
//  FarmViewModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 4/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
class ProductsViewModel {
    var jsonProducts = [ProductDataModel.Data]()
    var jsonVegetables =  [ProductDataModel.Data]()
    var jsonFruits =  [ProductDataModel.Data]()
    final let prodUrl = URL (string: "https://api.jsonbin.io/b/5f82ee18302a837e9578059e")
    
    
    init(){
        
        self.loadJsonData()
        
    }
    
    private func loadJsonData() {
        
        self.downloadJson(url: self.prodUrl!)
        
    }
    
    func downloadJson(url: URL?){
        guard let downloadURL = url else {
            return
        }
        URLSession.shared.dataTask(with: downloadURL){ data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else  {
                print("error in data transfer")
                return
            }
            do {
                 self.jsonProducts = try JSONDecoder().decode(ProductDataModel.self, from: data).products!
                self.setAllFruitsData()
                self.setAllVegetableData()
            } catch {
                print("decode error: \(error)")
            }
            
            }.resume()
    }
    
    
    func getVegetableCount() -> Int{
        var num = 0
        for products in jsonProducts{
            if products.type == "vegetable"{
                num = num + 1
            }
        }
        return num
    }
    func getFruitsCount() -> Int{
        var num = 0
        for products in jsonProducts{
            
            if products.type == "fruit"{
                num = num + 1
            }
            
        }
        return num
    }
    
    func setAllVegetableData() -> (){
           
            for products in jsonProducts{
                
                if products.type == "vegetable"{
                    jsonVegetables.append(products)
     
                }
                
            }
    }
  
    func setAllFruitsData() -> (){
        
            for products in jsonProducts{
                if products.type == "fruit"{
                    jsonFruits.append(products)
                    
                
            }
        
        }
        
    }
    // This method is returns the vegetables data
    public func getVegetableData() -> ([ProductDataModel.Data]){
        return (self.jsonVegetables)
    }
    // This method is returns the fruits data
    public func getFruitData()-> ([ProductDataModel.Data]){
        return (self.jsonFruits)
        
    }
}
