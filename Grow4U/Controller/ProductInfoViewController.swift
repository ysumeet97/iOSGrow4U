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
    
    private var searchVC: SearchResultController?
    
    // MARK: Properties
    @IBOutlet weak var innerScrollView: UIScrollView!
    @IBOutlet weak var product_image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var information: UITextView!
    
    @IBOutlet weak var l_product_image: UIImageView!
    @IBOutlet weak var l_name: UILabel!
    @IBOutlet weak var l_price: UILabel!
    @IBOutlet weak var l_information: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        dropShadow(layer: innerScrollView.layer)
        let data = searchVC!.getData()
        self.setupData(name: data.name, price: data.price, information: data.information)
    }
    
    public func dropShadow(layer: CALayer, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    public func setSearchVC(searchVC: SearchResultController) {
        self.searchVC = searchVC;
    }
    
//    public func setProductID(productInfoViewModel: ProductInfoViewModel, product_id: String) {
//        self.productInfoViewModel = productInfoViewModel
//        self.product_id = product_id
//    }
//    public func setName(name: String) {
//        print(name)
//        self.name!.text = name
//        self.l_name!.text = name
//    }
//
//    public func setPrice(price: String) {
//        print(price)
//        self.price!.text = "$ " + price + " / Kg"
//        self.l_price!.text = "$ " + price + " / Kg"
//    }
//
//    public func setInfo(information: String) {
//        self.information!.text = information
//        self.l_information!.text = information
//    }
    
    public func setupData(name: String, price: String, information: String) {
        self.name!.text = name
        self.l_name!.text = name
        self.price!.text = "$ " + price + " / Kg"
        self.l_price!.text = "$ " + price + " / Kg"
        self.information!.text = information
        self.l_information!.text = information
    }
}
