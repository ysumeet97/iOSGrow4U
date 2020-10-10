//
//  ProductInfoViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 2/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class ProductInfoViewController: UIViewController {
    
    private var searchRC: SearchResultController?
    
    // MARK: Properties
    @IBOutlet weak var innerScrollView: UIScrollView!
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var information: UITextView!
    @IBOutlet weak var farmersInfo: UITextView!
    
    @IBOutlet weak var l_product_image: UIImageView!
    @IBOutlet weak var l_name: UILabel!
    @IBOutlet weak var l_price: UILabel!
    @IBOutlet weak var l_information: UITextView!
    @IBOutlet weak var l_farmersInfo: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateData()
    }
    
    public func updateData() {
        let data = searchRC!.getData()
        self.setupData(name: data.name, price: data.price, information: data.information, img_url: data.img_url, farmers: data.farmers)
    }
    
    public func setSearchVC(searchVC: SearchResultController) {
        self.searchRC = searchVC;
    }
    
    public func setupData(name: String, price: String, information: String, img_url: String, farmers: [(name: String, rating: String, contact: String, offered_price: String)]) {
        self.name!.text = name
        self.l_name!.text = name
        self.price!.text = "$ " + price + " / Kg"
        self.l_price!.text = "$ " + price + " / Kg"
        self.information!.text = information
        self.l_information!.text = information
        self.setImage(from: img_url ,imageViewToSet: self.l_product_image)
        self.setImage(from: img_url ,imageViewToSet: self.product_image)
        self.setUpFarmersData(farmers: farmers)
    }
    
    func setUpFarmersData(farmers: [(name: String, rating: String, contact: String, offered_price: String)]) {
        var farmers_data: String = ""
        for farmer in farmers {
            farmers_data = farmers_data + "Name: " + farmer.name + "\nRating: " + farmer.rating  + " / 5" + "\nContact: " + farmer.contact + "\nOffered Price: " + farmer.offered_price + "\n" + "\n"
        }
        if farmers_data == ""{
            farmers_data = "No farmers are growing this product currently"
        }
        farmersInfo.text = farmers_data
        l_farmersInfo.text = farmers_data
    }
    
    func setImage(from url: String, imageViewToSet: UIImageView) {
        guard let imageURL = URL(string: url) else { return }
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    UIView.transition(with: imageViewToSet, duration: 0.2,
                                      options: [.transitionCrossDissolve],
                                      animations: { imageViewToSet.image = image
                    },
                                      completion: nil)
                }
            }  else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            UIView.transition(with: imageViewToSet, duration: 0.2,
                                              options: [.transitionCrossDissolve],
                                              animations: { imageViewToSet.image = image
                            },
                                              completion: nil)
                        }
                    }
                }).resume()
            }
        }
    }
}
