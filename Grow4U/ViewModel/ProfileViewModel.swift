//
//  ProfileViewModel.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 25/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import CoreData

class ProfileViewModel {
    var profile_model: ProfileData?
    var file_name: String
    var is_first = true
    let managedObjectContext =  CoreDataStorage.shared.managedObjectContext()
    
    init(file_name: String) {
        self.file_name = file_name
        loadJsonFile()
    }
    
    public func loadJsonFile() {
        var decoded_data : ProfileData?
        var fetchRequest: NSFetchRequest<ProfileData>
        var rec_count = -1
        do {
            fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
            let pr: [ProfileData]? = try managedObjectContext.fetch(fetchRequest)
            rec_count = pr!.count
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if(rec_count == 0){
            do {
                is_first = false
                let entity = NSEntityDescription.entity(forEntityName: "ProfileData", in: managedObjectContext)!
                let pro = NSManagedObject(entity: entity, insertInto: managedObjectContext)
                pro.setValue("", forKeyPath: "first_name")
                pro.setValue("", forKeyPath: "last_name")
                pro.setValue("", forKeyPath: "email")
                pro.setValue("", forKeyPath: "phone")
                pro.setValue("", forKeyPath: "address")
                pro.setValue([], forKeyPath: "preferences")
                fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
                var pf = try managedObjectContext.fetch(fetchRequest)
                decoded_data = pf[0]
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        } else{
            do {
                let documentsDirectory = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let url = documentsDirectory.appendingPathComponent("\(file_name).json")
                var p: [ProfileData]?
                fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
                p = try managedObjectContext.fetch(fetchRequest)
                decoded_data = p![0]
            } catch  {
                print(error)
            }
        }
        let documentsDirectory = try! FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let url = documentsDirectory.appendingPathComponent("\(file_name).json")
        setupProfileData(first_name: decoded_data!.first_name!, last_name: decoded_data!.last_name!, email: decoded_data!.email!, phone: decoded_data!.phone!, address: decoded_data!.address!, preferences: decoded_data!.preferences!)
    }
    
    public func writeJsonFile(profile: Dictionary<String, String>, preferences: [String]) {
        var fetchRequest: NSFetchRequest<ProfileData>
        var pr: [ProfileData]?
        do {
            fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
            pr = try managedObjectContext.fetch(fetchRequest)
            do {
                if(pr!.count > 1) {
                    let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ProfileData")
                    let request = NSBatchDeleteRequest(fetchRequest: fetch)
                    try managedObjectContext.execute(request)
                    try managedObjectContext.save()
                }
                
                fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
                pr = try managedObjectContext.fetch(fetchRequest)
                pr![0].setValue(profile["first_name"], forKey: "first_name")
                pr![0].setValue(profile["last_name"], forKey: "last_name")
                pr![0].setValue(profile["email"], forKey: "email")
                pr![0].setValue(profile["phone"], forKey: "phone")
                pr![0].setValue(profile["address"], forKey: "address")
                pr![0].setValue(preferences, forKey: "preferences")
                try managedObjectContext.save()
            }
        } catch {
            print(error)
        }
    }
    
    public func setupProfileData(first_name: String, last_name: String, email: String, phone: String, address: String, preferences: [String]) {
        profile_model = ProfileData(first_name: first_name, last_name: last_name, email: email, phone: phone, address: address, preferences: preferences)
        
    }
    
    public func getData() -> (first_name: String, last_name: String, email: String, phone: String, address: String, preferences: [String]) {
        
        return (profile_model!.first_name!, profile_model!.last_name!, profile_model!.email!, profile_model!.phone!, profile_model!.address!, profile_model!.preferences!)
    }
    
    public func updateData(first_name: String, last_name: String, email: String, phone: String, address: String, preferences: [String]) {
        profile_model?.first_name = first_name
        profile_model?.last_name = last_name
        profile_model?.email = email
        profile_model?.phone = phone
        profile_model?.address = address
        profile_model?.preferences = preferences
    }
}
