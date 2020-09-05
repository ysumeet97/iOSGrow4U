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
    private var downloadedProducts =  [SearchResultModel]()
    private var searchProducts = [SearchResultModel]()
    private var searching = false
    private var searchViewModel =  SearchViewModel(fileName: "prodcuts")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.tableFooterView = UIView()
    }
    
    func loadData() {
        self.downloadedProducts = searchViewModel.getJsonData()
        self.products = self.downloadedProducts
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searching {
           return searchProducts.count
        } else {
            return downloadedProducts.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.searching {
            self.products = self.searchProducts
        } else {
            self.products = self.downloadedProducts
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResult") as? SearchResultController else {return UITableViewCell()}
        cell.data = (name: products[indexPath.row].name, price: products[indexPath.row].price, information: products[indexPath.row].description)
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
    public func getData(indexPath: IndexPath) -> (name: String, price: String, information: String){
        return (name: products[indexPath.row].name, price: products[indexPath.row].price, information: products[indexPath.row].price.description)
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
