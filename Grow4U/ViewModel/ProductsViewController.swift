//
//  ProductsViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 22/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet var SearchBar: UISearchBar!
    override func viewDidLoad() {
        navigationItem.titleView = SearchBar
        
    }
    
    
}
