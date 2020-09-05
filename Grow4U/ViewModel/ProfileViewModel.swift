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
    var file_name: String
    
    init(file_name: String) {
        self.file_name = file_name
        loadJsonFile()
    }
    
    public func loadJsonFile() {
        let documentsDirectory = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let url = documentsDirectory.appendingPathComponent("\(file_name).json")
        
        // For printing the file location
        //        if let documentsPath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first?.path {
        //            print("Documents Directory: \(documentsPath)")
        //        }
        
        do {
            let profile_data = try Data(contentsOf: url)
            let decoded_data = try
                JSONDecoder().decode(ProfileModel.self, from: profile_data)
            setupProfileData(first_name: decoded_data.first_name, last_name: decoded_data.last_name, email: decoded_data.email, phone: decoded_data.phone, address: decoded_data.address)
        } catch  {
            print(error)
        }
    }
    
    public func writeJsonFile(profile: Dictionary<String, String>) {
        if let documentsDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).last {
            let url = documentsDirectory.appendingPathComponent("\(file_name).json")
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: profile, options: .init(rawValue: 0))
                do {
                    print(jsonData)
                    try jsonData.write(to: url)
                }
            } catch {
                print(error)
            }
        }
    }
    
    public func setupProfileData(first_name: String, last_name: String, email: String, phone: String, address: String) {
        self.profile_model = ProfileModel(first_name: first_name, last_name: last_name, email: email, phone: phone, address: address)
        
    }
    
    public func getData() -> (first_name: String, last_name: String, email: String, phone: String, address: String) {
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
