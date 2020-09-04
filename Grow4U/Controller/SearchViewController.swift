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
    private final let url = URL (string: "https://api.jsonbin.io/b/5f5070794d8ce4111387a7c9/4")
    private var products =  [SearchResultModel]()
    private var downloadedProducts =  [SearchResultModel]()
    private var searchProducts = [SearchResultModel]()
    private var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        tableView.tableFooterView = UIView()
    }
    
    func downloadJson() {
        guard let downloadURL = url else {
            return
        }
        URLSession.shared.dataTask(with: downloadURL){ data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else  {
                print("error in data transfer")
                return
            }
            print("downloaded")
            do {
                let decoder = JSONDecoder()
                self.downloadedProducts = try decoder.decode(SearchResults.self, from: data).products
                self.products = self.downloadedProducts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("decode error: \(error)")
            }
        }.resume()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResult") as? SearchResult else {return UITableViewCell()}
        cell.productName.text = products[indexPath.row].name
        cell.productPrice.text = "Price: " + products[indexPath.row].price + products[indexPath.row].currency + " / " + products[indexPath.row].unit
        setImage(from:products[indexPath.row].img_url ,  imageViewToSet: cell.productImg)
        cell.detailsButton.tag = Int(products[indexPath.row].id) ?? -1
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        return cell
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
