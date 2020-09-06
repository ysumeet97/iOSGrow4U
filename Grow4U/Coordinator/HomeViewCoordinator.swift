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
    
    init(tabController: HomeViewController, window: UIWindow) {
        self.tabController = tabController
        self.window = window
    }
    
    func start() {
        window.rootViewController = tabController
        window.makeKeyAndVisible()
        //showMain()
    }
    
//    private func showMain() {
//
//        // call the rest api to get the json file and set it in file_name
//        //file_name = "profile"
//        //  profile_model.loadJsonFile(file_name: file_name!)
//    }
//
//    func getProfileViewModel() -> ProfileViewModel {
//        return profile_model!
//    }
    
   
}
