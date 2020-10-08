//
//  ViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 21/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
import UIKit

class HomeViewController: UITabBarController {
    
    let selectedColor = UIColor(red: 0, green: 128/255.0, blue: 255/255.0, alpha: 1.00)
    let deselectedColor = UIColor.gray
    var window: UIWindow?
    var productVC: Any?
    var profileVC: ProfileViewController?
    var pronavVC: ProductNavController?
    private var file_name: String?
    private var profile_model: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self as? UITabBarControllerDelegate;
        tabBar.tintColor = selectedColor
        tabBar.unselectedItemTintColor = deselectedColor
        tabBar.barTintColor = UIColor.white.withAlphaComponent(0.92)
        file_name = "profile"
        profile_model = ProfileViewModel(file_name: file_name!)
        
        productVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavController") as! NavController
        profileVC = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController)
        pronavVC = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductNavController") as! ProductNavController)
        self.setViewControllers([productVC! as! NavController, pronavVC!, profileVC!], animated: true)
//        UIApplication.statusBarBackgroundColor = UIColor(red: 21/255, green: 178/255, blue: 65/255, alpha: 1)
        
        if(UIDevice.current.orientation.isLandscape) {
            productVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsLandscapeViewController") as! ProductsLandscapeViewController
            self.setViewControllers([productVC! as! UIViewController, pronavVC!, profileVC!], animated: true)
        }
        else {
            productVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavController") as! NavController
            self.setViewControllers([productVC! as! NavController, pronavVC!, profileVC!], animated: true)
        }
        profileVC!.setProfileModel(profileViewModel: profile_model!)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(UIDevice.current.orientation.isLandscape) {
            productVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplitViewController") as! SplitViewController
            self.setViewControllers([productVC! as! UIViewController, pronavVC!, profileVC!], animated: true)
            
        }
        else {
            productVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavController") as! NavController
            self.setViewControllers([productVC! as! NavController, pronavVC!, profileVC!], animated: true)
            
        }
        
    }
    
}

