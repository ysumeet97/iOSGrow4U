//
//  ProductsViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 22/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    //@IBOutlet var SearchBar: UISearchBar!
   // @IBOutlet var searchBar: [UISearchBar]!
    @IBOutlet var search: UISearchBar!
    @IBOutlet weak var navigation: UINavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigation.topItem?.titleView = search
        //self.tabBarController?.navigationItem.leftBarButtonItem = settingsButton
    }
    
    
}
