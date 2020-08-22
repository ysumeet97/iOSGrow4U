//
//  ProductsViewCoordinator.swift
//  Grow4U
//
//  Created by vaishali wahi on 22/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class ProductsViewCoordinator : MainCoordinator {
    let parentViewController: UIViewController
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func start() {
        let productsViewController = ProductsViewController()
        parentViewController.present(productsViewController, animated: true)
    }
}
