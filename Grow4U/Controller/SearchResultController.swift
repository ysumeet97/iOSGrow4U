//
//  SearchResult.swift
//  Grow4U
//
//  Created by Sainath Reddy K on 2/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

class SearchResultController: UITableViewCell {

    var product_info: String?
    var searchVC: SearchViewController?
    var productVC: ProductInfoViewController?
    var indexPath: IndexPath?
    var data: (name: String, price: String, information: String, img_url: String, farmers: [(name: String, rating: String, contact: String, offered_price: String)])?
    
    
    // MARK:- Properties
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoViewController") as? ProductInfoViewController
        productVC!.setSearchVC(searchVC: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    public func getData() -> (name: String, price: String, information: String, img_url: String, farmers: [(name: String, rating: String, contact: String, offered_price: String)]) {
        return data!
    }
    
    public func setSearchVC(searchVC: SearchViewController, indexPath: IndexPath){
        self.searchVC = searchVC
        self.indexPath = indexPath
    }
    
    // MARK:- Actions
    @IBAction func showProductDetails(_ sender: UIButton) {
        self.searchVC!.showProductInfo(productVC: productVC!)
    }
    
}
