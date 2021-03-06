//
//  FarmDetailViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 9/10/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

class FarmDetailViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var rating: UILabel!
    @IBOutlet var information: UITextView!
    @IBOutlet var products: UITextView!
    @IBOutlet var l_image: UIImageView!
    @IBOutlet var l_rating: UILabel!
    @IBOutlet var l_name: UILabel!
    @IBOutlet var l_information: UITextView!
    @IBOutlet var l_products: UITextView!
    
    
    var id:String?
    var type: String?
    var image_url:String?
    var prod_price:String?
    var prod_description:String?
    var farmers = [String]()
    var locations = [String]()
    var click_name:String?
    var farmer_type:String?
    var farmer_rating:String?
    var farmer_contact:String?
    var farmer_products = [String]()
    var farmer_location = [String]()
    var categories = [ImageCategory]()
    let products_model = ProductsTableViewController.products_model
    let farms_model = ProductsTableViewController.farms_model
    override func viewDidLoad() {
        super.viewDidLoad()
        let vegetableData = products_model.getVegetableData()
        let fruitData = products_model.getFruitData()
        let farmData = farms_model.getFarmsData()
        if( id!.contains("FA")){
            type = "farms"
        }
        else if((id!.contains("FR"))){
            type = "fruit"
        }
        else
        {
            type = "vegetable"
        }
        if self.type == "vegetable"{
            for vegetables in vegetableData{
                if ((self.id?.elementsEqual(vegetables.id!))!){
                    self.click_name = vegetables.name
                    self.image_url = vegetables.img_url
                    self.prod_price = vegetables.price
                    self.prod_description = vegetables.description!
                    for farmer in vegetables.farmers{
                        farmers.append(farmer!)
                    }
                    for location in vegetables.locations{
                        locations.append(location!)
                    }
                }
            }
            
        }
        else if(self.type == "fruit"){
            for fruit in fruitData{
                if ((self.id?.elementsEqual(fruit.id!))!){
                    self.click_name = fruit.name
                    self.image_url = fruit.img_url
                    self.prod_price = fruit.price
                    self.prod_description = fruit.description!
                    for farmer in fruit.farmers{
                        farmers.append(farmer!)
                    }
                    for location in fruit.locations{
                        locations.append(location!)
                    }
                }
            }
        }
        else{
            for farm in farmData{
                if ((self.id?.elementsEqual(farm.id!))!){
                    self.image_url = farm.img_url
                    self.click_name = farm.name
                    self.farmer_type = farm.type
                    self.farmer_rating = farm.rating
                    self.farmer_contact = farm.contact
                    for product in farm.products!{
                        self.farmer_products.append(product.id!)
                    }
                    for location in farm.locations!{
                        self.farmer_location.append(location)
                    }
                    
                }
            }
        }
        
        setImage(from: self.image_url!, imageViewToSet: self.image)
        setImage(from: self.image_url!, imageViewToSet: self.l_image)
        self.name.text = self.click_name
        self.l_name.text = self.click_name
        self.rating.text = self.farmer_rating!+" /5"
        self.l_rating.text = self.farmer_rating!+" /5"
        var text = "\nContact Details: " + self.farmer_contact! + "\nType: " + self.farmer_type! + "\nLocated at: "
        for location in self.farmer_location{
            text = text + "\n"  + location
        }
        self.information.text = text
        self.l_information.text = text
        var prodText = ""
        for product in vegetableData{
            for id in farmer_products{
                if((product.id!.elementsEqual(id))){
                    prodText = prodText + "Vegetable Name: " + product.name! + "\nVegetable Price: " + product.price! + "\n\n"
                }
            }
            
        }
        for product in fruitData{
            for id in farmer_products{
                if((product.id!.elementsEqual(id))){
                    prodText = prodText+"\nFruit Name: " + product.name! + "\nFruit Price: " + product.price!+"\n\n"
                }
            }
        }
        self.products.text = prodText
        self.l_products.text = prodText
    }
    
    func setImage(from url: String, imageViewToSet: UIImageView) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageViewToSet.image = image
            }
        }
    }
}
