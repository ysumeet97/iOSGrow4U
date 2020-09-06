//
//  SearchViewController.swift
//  Grow4U
//
//  Created by Sainath Reddy K on 24/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    
    // MARK: -Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var products =  [SearchResultModel]()
    private var farms =  [FarmsModel.Data]()
    private var downloadedProducts =  (products: [SearchResultModel](), farms: [FarmsModel.Data]())
    private var searchProducts = [SearchResultModel]()
    private var searching = false
    private var searchViewModel =  SearchViewModel(fileName: (products: "prodcuts", farmers: "farms"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.tableFooterView = UIView()
    }
    
    func loadData() {
        self.downloadedProducts = searchViewModel.getJsonData()
        self.products = self.downloadedProducts.products
        self.farms = self.downloadedProducts.farms
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searching {
           return searchProducts.count
        } else {
            return downloadedProducts.products.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searching {
            self.products = self.searchProducts
        } else {
            self.products = self.downloadedProducts.products
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResult") as? SearchResultController else {return UITableViewCell()}
        cell.data = getData(indexPath: indexPath)
        cell.setSearchVC(searchVC: self, indexPath: indexPath)
        //self.setProductInfo(indexPath: indexPath)
        cell.product_info = products[indexPath.row].description
        cell.productName.text = products[indexPath.row].name
        cell.productPrice.text = "Price: " + products[indexPath.row].price + products[indexPath.row].currency + " / " + products[indexPath.row].unit
        setImage(from:products[indexPath.row].img_url ,  imageViewToSet: cell.productImg)
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.40
        return cell
    }
    public func getData(indexPath: IndexPath) -> (name: String, price: String, information: String, img_url: String, farmers: [(name: String, rating: String, contact: String, offered_price: String)]){
        let farmers = getFarmers(product_id: products[indexPath.row].id)
        return (name: products[indexPath.row].name, price: products[indexPath.row].price, information: products[indexPath.row].description, products[indexPath.row].img_url, farmers: farmers)
    }
    
    public func getFarmers(product_id: String) -> [(name: String, rating: String, contact: String, offered_price: String)] {
        var farmers_info = [(name: String, rating: String, contact: String, offered_price: String)]()
        for farmers in farms {
            for prods in farmers.products! {
                if(product_id == prods.id!){
                    farmers_info.append((name: farmers.name!, rating: farmers.rating!, contact: farmers.contact!, offered_price: prods.offered_price!))
                    break;
                }
            }
        }
        return farmers_info
    }
    
    func showProductInfo(productVC: ProductInfoViewController) {
        self.navigationController?.pushViewController(productVC, animated: true)
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

    func searchBar (_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchProducts = products.filter({$0.name.lowercased().contains(searchText.lowercased())})
        searching = true
        } else {
            searching = false
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}
