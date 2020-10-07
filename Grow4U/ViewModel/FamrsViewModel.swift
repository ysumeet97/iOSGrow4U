//
//  FarmsViewModel.swift
//  Grow4U
//
//  Created by vaishali wahi on 5/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
class FarmsViewModel {
    private var farmsImagesUrl = [String]()
    private var farms_name = [String]()
    private var farms_ratings = [String]()
    private var farms_model: [FarmsModel.Data]?
    var file_name: String
    
    init(file_name: String) {
        self.file_name = file_name
        loadJsonFile()
    }
    
    public func loadJsonFile() {
        guard let path = Bundle.main.path(forResource: file_name, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let farms_data = try Data(contentsOf: url)
            let decoded_data = try
                JSONDecoder().decode(FarmsModel.self, from: farms_data)
            setupFarmsData(data: decoded_data.farm)
        } catch  {
            print(error)
        }
    }
    
    public func setupFarmsData(data: [FarmsModel.Data]) {
        self.farms_model = data
    }
    
    func getFarmsCount()->Int{
        var num = 0
        num = num + farms_model!.count
        return num
    }
    
    
    func getAllFarmsData()->(images_Url: [String], farms_name: [String], farms_ratings: [String]){
        for data in farms_model!{
            self.farmsImagesUrl.append(data.img_url!)
            self.farms_name.append(data.name!)
            self.farms_ratings.append(data.rating!)
            
        }
        return(farmsImagesUrl,farms_name,farms_ratings)
    }
}
