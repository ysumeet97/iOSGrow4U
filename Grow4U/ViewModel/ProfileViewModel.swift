//
//  ProfileViewModel.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation

class ProfileViewModel {
    private var profile_model: ProfileModel?
    private var file_name: String?
    private var first_name: String?
    private var last_name: String?
    private var email: String?
    private var phone: String?
    private var address: String?
    
    init(file_name: String) {
        self.file_name = file_name
        loadJsonFile()
    }
    
    public func loadJsonFile() {
        guard let path = Bundle.main.path(forResource: file_name, ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let profile_data = try Data(contentsOf: url)
            let decoded_data = try
                JSONDecoder().decode(ProfileModel.self, from: profile_data)
            print("setting")
            setupProfileData(first_name: decoded_data.first_name, last_name: decoded_data.last_name, email: decoded_data.email, phone: decoded_data.phone, address: decoded_data.address)
            print("done")
        } catch  {
            print(error)
        }
    }
    
    public func setupProfileData(first_name: String, last_name: String, email: String, phone: String, address: String) {
        self.profile_model = ProfileModel(first_name: first_name, last_name: last_name, email: email, phone: phone, address: address)
        print("hi1:" + profile_model!.address)
        
    }
    
    public func getData() -> (first_name: String, last_name: String, email: String, phone: String, address: String) {
        print("hi2: " + profile_model!.address)
        return (profile_model!.first_name, profile_model!.last_name, profile_model!.email, profile_model!.phone, profile_model!.address)
    }
    
    public func updateData(first_name: String, last_name: String, email: String, phone: String, address: String) {
        profile_model?.first_name = first_name
        profile_model?.last_name = last_name
        profile_model?.email = email
        profile_model?.phone = phone
        profile_model?.address = address
    }
}
