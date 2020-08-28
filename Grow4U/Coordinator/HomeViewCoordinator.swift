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
    
    private let tabController: HomeViewController
    private let window: UIWindow
    private var file_name: String?

    init(tabController: HomeViewController, window: UIWindow) {
        self.tabController = tabController
        self.window = window
    }
    
    func start() {
        window.rootViewController = tabController
        window.makeKeyAndVisible()
        showMain()
    }
    
    private func showMain() {
        let productVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        tabController.setViewControllers([productVC, profileVC], animated: true)
        file_name = "profile"
        let profile_model = ProfileViewModel(file_name: file_name!)
        profileVC.setProfileModel(profileViewModel: profile_model)
        
        // call the rest api to get the json file and set it in file_name
        //file_name = "profile"
      //  profile_model.loadJsonFile(file_name: file_name!)
    }
    
}
