//
//  CodingUserInfoKey+Util.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 18/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
     //static let managedObjectContext = CoreDataStorage.shared.persistentContainer.viewContext
}
