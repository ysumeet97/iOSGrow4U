//
//  ProductInfoViewModel.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 2/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation

class ProductInfoViewModel {
    
    private var file_name: String
    private var productInfoModel: ProductInfoModel?
    
    init(file_name: String){
        self.file_name = file_name
    }
    
    public func getProductInfo(product_id: String) -> ProductInfoModel.Data{
        var product_details: ProductInfoModel.Data?
        let documentsDirectory = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        //guard let path = Bundle.main.path(forResource: "product_info", ofType: "json") else { return}
        let url = documentsDirectory.appendingPathComponent("\(file_name).json")
        //let url = URL(fileURLWithPath: path)
        do {
            let product_data = try Data(contentsOf: url)
            let decoded_data = try
                JSONDecoder().decode(ProductInfoModel.self, from: product_data)
            for product in decoded_data.products! {
                if (product.product_id! == product_id) {
                    product_details = product
                }
            }
            
        } catch  {
            print(error)
        }
        return product_details!
    }
    
}
