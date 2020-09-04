//
//  ProfileModel.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 24/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation

class ProfileModel: Decodable, Encodable {
    //private var image: String
    var first_name: String
    var last_name: String
    var email: String
    var phone: String
    var address: String
    
    init(first_name: String, last_name: String, email: String, phone: String, address: String) {
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone = phone
        self.address = address
    }
    
    
}
