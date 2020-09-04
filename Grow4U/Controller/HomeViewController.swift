//
//  ViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 21/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
import UIKit

class HomeViewController: UITabBarController {
    
    let selectedColor = UIColor.blue
    let deselectedColor = UIColor.gray
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self as? UITabBarControllerDelegate;
        tabBar.tintColor = selectedColor
        tabBar.unselectedItemTintColor = deselectedColor
        tabBar.barTintColor = UIColor.white.withAlphaComponent(0.92)
    }
    
}