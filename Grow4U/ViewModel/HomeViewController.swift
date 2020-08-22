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
    
    override func viewDidLoad() {
        //view.backgroundColor = .blue
        
        //self.delegate = self as! UITabBarControllerDelegate
        tabBar.tintColor = selectedColor
        tabBar.unselectedItemTintColor = deselectedColor
        tabBar.barTintColor = UIColor.white.withAlphaComponent(0.92)
        
        
        //setUp()
        
        //self.selectPage(at: 1)
        // Do any additional setup after loading the view.
        
    }

   
}

