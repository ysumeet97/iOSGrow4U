//
//  FarmViewModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 4/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
class ProductsViewModel {
    private var imagesUrl = [String]()
    private var type = [String]()
    private var type_price = [String]()
    private var products_model: [ProductDataModel.Data]?
    var file_name: String
    
    init(file_name: String) {
        self.file_name = file_name
        loadJsonFile()
    }
    
    public func loadJsonFile() {
        guard let path = Bundle.main.path(forResource: file_name, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            // print(products.locations )
           // self.pdata = products.locations
            //self.location = locations.locations
            let products_data = try Data(contentsOf: url)
            let decoded_data = try
                JSONDecoder().decode(ProductDataModel.self, from: products_data)
            setupProductData(data: decoded_data.locations!)
            print("productsdone")
        } catch  {
            print(error)
        }
    }
    
    public func setupProductData(data: [ProductDataModel.Data]) {
       self.products_model = data
        
        
    }
    
//    func getFarmsCount()->Int{
//        var num = 0
//        num = num + farmsData!.count
//        return num
//    }
    
    func getVegetableCount() -> Int{
        var num = 0
        for locations in products_model!{
            
            let vegetables = locations.vegetables
            num = num + vegetables!.count
            
        }
        return num
    }
//    func getAllFarmsData(){
//
//
//        for data in farmsData!{
//
//            farmsImagesUrl.append(data.image!)
//            farms_name.append(data.name!)
//            farms_ratings.append(data.ratings!)
//
//        }
//
//    }
    func getAllData() -> (images_Url: [String], type: [String], type_price: [String]){
        
        
        for locations in products_model!{
            for data in locations.vegetables!{
                imagesUrl.append(data.image!)
                type.append(data.type!)
                type_price.append(data.price!)
            }
        }
        return(imagesUrl,type,type_price)
    }
}
