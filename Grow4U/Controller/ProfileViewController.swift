//
//  ProfileViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    var profileViewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profile_data = profileViewModel!.getData()
        self.setTextData(first_name: profile_data.first_name, last_name: profile_data.last_name, email: profile_data.email, phone: profile_data.phone, address: profile_data.address)
    }
    
    private func setTextData(first_name: String, last_name: String, email: String, phone: String, address: String) {
        firstNameTextField.text = first_name
        lastNameTextField.text = last_name
        emailTextField.text = email
        phoneTextField.text = phone
        addressTextField.text = address
    }
    
    public func setProfileModel(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
    }
    //MARK: Actions
    
    @IBAction func editProfileData(_ sender: UIButton) {
    }
    
    @IBAction func homeButtonAction(_ sender: UIButton) {
            self.performSegue(withIdentifier: "homeSeague", sender: sender)
    }
}
