////
////  ProfileModel.swift
////  Grow4U
////
////  Created by Sumeet Yedula on 24/8/20.
////  Copyright © 2020 Grow4U. All rights reserved.
////
//
<<<<<<< Updated upstream
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
=======
//import UIKit
//import CoreData
//
//class ProfileModel: NSManagedObject, Codable
//{
//    @NSManaged var first_name: String?
//    @NSManaged var last_name: String?
//    @NSManaged var email: String?
//    @NSManaged var phone: String?
//    @NSManaged var address: String?
//    @NSManaged var image: String?
//
//    enum CodingKeys: String, CodingKey {
//        case first_name
//        case last_name
//        case email
//        case phone
//        case address
//        case image
//    }
//
//    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
//        super.init(entity: entity, insertInto: context)
//    }
//
//    init(first_name: String, last_name: String, email: String, phone: String, address: String, image: String) {
//        let managedObjectContext = CoreDataStorage.shared.managedObjectContext()
//        let entity = NSEntityDescription.entity(forEntityName: "ProfileData", in: managedObjectContext)
//        super.init(entity: entity!, insertInto: managedObjectContext)
//        self.first_name = first_name
//        self.last_name = last_name
//        self.email = email
//        self.phone = phone
//        self.address = address
//        self.image = image
//    }
//
//    required convenience init(from decoder: Decoder) throws {
//        let managedObjectContext = CoreDataStorage.shared.managedObjectContext()
//        //guard let managedObjectContext = decoder.userInfo[CodingUserInfoKey.managedObjectContext!] as? NSManagedObjectContext else { fatalError("Failed to decode User") }
//        guard let entity = NSEntityDescription.entity(forEntityName: "ProfileData", in: managedObjectContext) else { fatalError("Failed to decode User") }
//
//        self.init(entity: entity, insertInto: managedObjectContext)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        first_name = try container.decode(String.self, forKey: .first_name)
//        last_name = try container.decode(String.self, forKey: .last_name)
//        email = try container.decode(String.self, forKey: .email)
//        phone = try container.decode(String.self, forKey: .phone)
//        address = try container.decode(String.self, forKey: .address)
//        image = try container.decode(String.self, forKey: .image)
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(first_name, forKey: .first_name)
//        try container.encode(last_name, forKey: .last_name)
//        try container.encode(email, forKey: .email)
//        try container.encode(phone, forKey: .phone)
//        try container.encode(address, forKey: .address)
//        try container.encode(image, forKey: .image)
//    }
//
//
//
//}
>>>>>>> Stashed changes
