//
//  SearchViewController.swift
//  Grow4U
//
//  Created by Sainath Reddy K on 24/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate {
    
    // MARK: -Properties
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var products =  [SearchResultModel]()
    private var farms =  [FarmsModel.Data]()
    private var downloadedProducts =  (products: [SearchResultModel](), farms: [FarmsModel.Data]())
    private var searchProducts = [SearchResultModel]()
    private var searching = false
    private var searchViewModel =  SearchViewModel(fileName: (products: "prodcuts", farmers: "farms"))
    private var displayNoResults = false
    private let noImageName = "noResult.jpeg"
    private var noImageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.tableFooterView = UIView()
        searchBar.backgroundImage = UIImage()
        let noImage = UIImage(named: noImageName)
        noImageView = UIImageView(image: noImage!)
        noImageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300
        )
        noImageView.isHidden = true
        self.tableView.addSubview(noImageView)
        noImageView.translatesAutoresizingMaskIntoConstraints = false
        noImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        noImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        noImageView.centerXAnchor.constraint(lessThanOrEqualTo: noImageView.superview!.centerXAnchor).isActive = true
        noImageView.centerYAnchor.constraint(lessThanOrEqualTo: noImageView.superview!.centerYAnchor).isActive = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.searchBar.endEditing(true)
    }
    
    // This function is used to load the data of products
    func loadData() {
        self.downloadedProducts = searchViewModel.getJsonData()
        self.products = self.downloadedProducts.products
        self.farms = self.downloadedProducts.farms
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        self.searchBar.endEditing(true)
    }
    
    // This function returns the number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searching {
            return searchProducts.count
        } else {
            return downloadedProducts.products.count
        }
    }
    
    
    // This function is used to set the cell of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searching {
            self.products = self.searchProducts
        } else {
            self.products = self.downloadedProducts.products
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResult") as? SearchResultController else {return UITableViewCell()}
        cell.data = getData(indexPath: indexPath)
        cell.setSearchVC(searchVC: self, indexPath: indexPath)
        cell.product_info = products[indexPath.row].description
        cell.productName.text = products[indexPath.row].name
        cell.productPrice.text = "Price: " + products[indexPath.row].price + products[indexPath.row].currency + " / " + products[indexPath.row].unit
        setImage(from:products[indexPath.row].img_url ,  imageViewToSet: cell.productImg)
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    // This function is used to get the famers contact info
    public func getData(indexPath: IndexPath) -> (name: String, price: String, information: String, img_url: String, farmers: [(name: String, rating: String, contact: String, offered_price: String)]){
        let farmers = getFarmers(product_id: products[indexPath.row].id)
        return (name: products[indexPath.row].name, price: products[indexPath.row].price, information: products[indexPath.row].description, products[indexPath.row].img_url, farmers: farmers)
    }
    
    // This method is used to get the farmers data
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
        if (productVC.name != nil) {
            productVC.updateData()
        }
    }
    
    // This function is used to set the image in UIImageView
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
    
    
    // This function acts as search handler
    func searchBar (_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchProducts = products.filter({$0.name.lowercased().contains(searchText.lowercased())})
            if (!displayNoResults &&  searchProducts.count<1) {
                displayNoResults = true
                self.noImageView.isHidden = false
            } else if (displayNoResults && searchProducts.count>0){
                displayNoResults = false
                self.noImageView.isHidden = true
            }
            searching = true
        } else {
            searching = false
            if (displayNoResults){
                displayNoResults = false
                self.noImageView.isHidden = true
            }
        }
        tableView.reloadData()
    }
    
    // This function acts as cancel button handler
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        if (displayNoResults){
            displayNoResults = false
            self.noImageView.isHidden = true
        }
        tableView.reloadData()
    }
    
}
