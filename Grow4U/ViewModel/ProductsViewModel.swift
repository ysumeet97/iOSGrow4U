//
//  FarmViewModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 4/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
class ProductsViewModel {
    
    private var jsonProducts = [ProductDataModel.Data]()
    private var jsonVegetables =  [ProductDataModel.Data]()
    private var jsonFruits =  [ProductDataModel.Data]()
    private var id = [String]()
    private var image_url = [String]()
    private var type = [String]()
    private var name = [String]()
    private var availability = [String]()
    private var max_quantity = [String]()
    private var description = [String]()
    private var price = [String]()
    private var unit = [String]()
    private var Currency = [String]()
    private var location = [String]()
    private var farmers = [String]()
    private final let prodUrl = URL (string: "https://api.jsonbin.io/b/5f7d3dd97243cd7e824bfd61/5")
    
    
    init(){
        
        self.loadJsonData()
        
    }
    
    private func loadJsonData() {
        
        self.downloadJson(url: self.prodUrl!)
        
    }
    
    private func downloadJson(url: URL?){
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
    
    func getAllVegetableData() -> (id : [String],image_url : [String], type : [String],name : [String]
        ,availability : [String], max_quantity : [String], description : [String], price : [String],unit : [String]
        ,Currency : [String] , location : [String], farmers : [String]){
            removeAllData()
            for products in jsonProducts{
                
                if products.type == "vegetable"{
                    jsonVegetables.append(products)
                    id.append(products.id!)
                    image_url.append(products.img_url!)
                    type.append(products.type!)
                    name.append(products.name!)
                    availability.append(products.availability!)
                    max_quantity.append(products.max_quantity!)
                    description.append(products.description!)
                    unit.append(products.unit!)
                    price.append(products.price!)
                    Currency.append(products.currency!)
                    for locations in products.locations{
                        location.append(locations!)
                    }
                    for farmer in products.farmers{
                        farmers.append(farmer!)
                    }
                    
                    
                }
                
            }
            
            return(id , image_url , type , name , availability , max_quantity, description , price , unit , Currency , location , farmers )
    }
    private func removeAllData(){
        id.removeAll()
        image_url.removeAll()
        type.removeAll()
        name.removeAll()
        availability.removeAll()
        max_quantity.removeAll()
        description.removeAll()
        unit.removeAll()
        price.removeAll()
        Currency.removeAll()
        location.removeAll()
        farmers.removeAll()
    }
    func getAllFruitsData() -> (id : [String],image_url : [String], type : [String],name : [String]
        ,availability : [String], max_quantity : [String], description : [String], price : [String],unit : [String]
        ,Currency : [String] , location : [String], farmers : [String]){
            removeAllData()
            for products in jsonProducts{
                if products.type == "fruit"{
                    jsonFruits.append(products)
                    id.append(products.id!)
                    image_url.append(products.img_url!)
                    type.append(products.type!)
                    name.append(products.name!)
                    availability.append(products.availability!)
                    max_quantity.append(products.max_quantity!)
                    description.append(products.description!)
                    unit.append(products.unit!)
                    price.append(products.price!)
                    Currency.append(products.currency!)
                    for locations in products.locations{
                        location.append(locations!)
                    }
                    for farmer in products.farmers{
                        farmers.append(farmer!)
                    }
                }
                
            }
            return(id , image_url , type , name , availability , max_quantity, description , price , unit , Currency , location , farmers )
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
