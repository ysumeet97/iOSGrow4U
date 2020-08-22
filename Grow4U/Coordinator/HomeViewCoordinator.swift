//
//  HomeViewCoordinator.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 21/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class HomeViewCoordinator : MainCoordinator {
    let parentViewController: UIViewController
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func start() {
        let homeViewController = HomeViewController()
       
        parentViewController.present(homeViewController, animated: true)
    }
}
