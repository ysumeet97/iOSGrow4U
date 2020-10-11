//
//  FarmsViewModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 5/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
class FarmsViewModel {
    private var id = [String]()
    private var farmsImagesUrl = [String]()
    private var farms_name = [String]()
    private var farms_ratings = [String]()
    var farms_model = [FarmsModel.Data]()
    private var products = [FarmsModel.products_info]()
    private var offered_products = [[FarmsModel.products_info]]()
    private final let farmUrl = URL (string: "https://api.jsonbin.io/b/5f7d3e3d302a837e95760f33/4")
    
    init(){
        self.loadJsonData()
    }
    private func loadJsonData() {
        self.downloadJson(url: self.farmUrl!)
        
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
                
                self.farms_model = try JSONDecoder().decode(FarmsModel.self, from: data).farm!
            }
            catch {
                print("decode error: \(error)")
            }
            
            }.resume()
    }
    
    func getFarmsCount()->Int{
        var num = 0
        num = num + farms_model.count
        return num
    }
    
    public func getFarmsData()-> ([FarmsModel.Data]){
        return (self.farms_model)
        
    }
    func getAllFarmsData()->(id:[String],images_Url: [String], farms_name: [String], farms_ratings: [String], offered_products: [[FarmsModel.products_info]] ){
        for data in farms_model{
            self.id.append(data.id!)
            self.farmsImagesUrl.append(data.img_url!)
            self.farms_name.append(data.name!)
            self.farms_ratings.append(data.rating!)
            for productData in data.products! {
                self.products.append(productData)
            }
            self.offered_products.append(self.products)
        }
        return(id,farmsImagesUrl,farms_name,farms_ratings,offered_products)
    }
}
