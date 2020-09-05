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
    
    private var productInfoViewModel: ProductInfoViewModel?
    private var product_id: String?
    
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
        self.setupData()
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
    
    public func setProductID(productInfoViewModel: ProductInfoViewModel, product_id: String) {
        self.productInfoViewModel = productInfoViewModel
        self.product_id = product_id
    }
    
    private func setupData() {
        print("setup data: " + product_id!)
        let product_details = self.productInfoViewModel!.getProductInfo(product_id: product_id!)
        name.text = product_details.product_name
        l_name.text = product_details.product_name
        price.text = "$ " + product_details.product_price! + " / Kg"
        l_price.text = "$ " + product_details.product_price! + " / Kg"
        information.text = product_details.product_info
        l_information.text = product_details.product_info
    }
}
