//
//  ProfileViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: Properties
    @IBOutlet weak var outerScrollView: UIScrollView!
    @IBOutlet weak var innerScrollView: UIScrollView!
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var profileViewModel: ProfileViewModel?
    var profile_data: (first_name: String, last_name: String, email: String, phone: String, address: String)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outerScrollView.delegate = self
        self.setImage()
        profile_data = profileViewModel!.getData()
        self.setTextData(first_name: profile_data!.first_name, last_name: profile_data!.last_name, email: profile_data!.email, phone: profile_data!.phone, address: profile_data!.address)
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            scrollView.contentOffset.x = 0
    }
    
    private func setTextFieldProperties(value: Bool) {
        self.firstNameTextField.isUserInteractionEnabled = value
        self.lastNameTextField.isUserInteractionEnabled = value
        self.phoneTextField.isUserInteractionEnabled = value
        self.addressTextField.isUserInteractionEnabled = value
        self.emailTextField.isUserInteractionEnabled = value
    }
    
    private func setButtonProperties(value: Bool) {
        saveButton.isHidden = value
        cancelButton.isHidden = value
    }
    
    private func setTextData(first_name: String, last_name: String, email: String, phone: String, address: String) {
        firstNameTextField.text = first_name
        lastNameTextField.text = last_name
        emailTextField.text = email
        phoneTextField.text = phone
        addressTextField.text = address
    }
    
    private func setImage() {
        self.profile_image.layer.cornerRadius = self.profile_image.frame.size.width / 2;
        self.profile_image.clipsToBounds = true
    }
    
    public func setProfileModel(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
    }
    
    //MARK: Actions
    @IBAction func editProfileData(_ sender: UIButton) {
        self.setTextFieldProperties(value: true)
        self.setButtonProperties(value: false)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let profile_data = ["first_name": self.firstNameTextField.text!,
                    "last_name": self.lastNameTextField.text!,
                    "email": self.emailTextField.text!,
                    "phone": self.emailTextField.text!,
                    "address": self.addressTextField.text!]
        profileViewModel?.writeJsonFile(profile: profile_data)
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
        showAlertButtonTapped(saveButton)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        self.setTextData(first_name: profile_data!.first_name, last_name: profile_data!.last_name, email: profile_data!.email, phone: profile_data!.phone, address: profile_data!.address)
        self.setTextFieldProperties(value: false)
        self.setButtonProperties(value: true)
    }
    
    @IBAction func showAlertButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title:"", message: "Profile\nUpdated!", preferredStyle: .alert)
        alert.setValue(NSAttributedString(string: "Profile\nUpdated!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18),NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
