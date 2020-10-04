//
//  ProfileData+CoreDataProperties.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 20/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
//

import Foundation
import CoreData


extension ProfileData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfileData> {
        return NSFetchRequest<ProfileData>(entityName: "ProfileData")
    }

    @NSManaged public var first_name: String?
    @NSManaged public var last_name: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var address: String?
    @NSManaged public var image: String?

}
