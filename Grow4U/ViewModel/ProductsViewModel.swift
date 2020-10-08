//
//  FarmViewModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 4/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
class ProductsViewModel {
    
    
    private var products_model: [ProductDataModel.Data]?
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
    var file_name: String?
    
    init(file_name: String?) {
        self.file_name = file_name
        loadJsonFile()
    }
    
    public func loadJsonFile() {
        guard let path = Bundle.main.path(forResource: file_name, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let products_data = try Data(contentsOf: url)
            let decoded_data = try
                JSONDecoder().decode(ProductDataModel.self, from: products_data)
            setupProductData(data: decoded_data.products!)
        } catch  {
            print(error)
        }
    }
    
    public func setupProductData(data: [ProductDataModel.Data]) {
        self.products_model = data
        
        
    }
    
    
    func getVegetableCount() -> Int{
        var num = 0
        for products in products_model!{
            if products.type == "vegetable"{
                num = num + 1
            }
        }
        return num
    }
    func getFruitsCount() -> Int{
        var num = 0
        for products in products_model!{
            
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
            
            for products in products_model!{
                
                if products.type == "vegetable"{
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
    func removeAllData(){
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
            for products in products_model!{
                if products.type == "fruit"{
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
}
