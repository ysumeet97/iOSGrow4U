//
//  ProfileTests.swift
//  Grow4UTests
//
//  Created by Sainath Reddy K on 10/10/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import XCTest
@testable import Grow4U
import CoreData

class ProfileTests: XCTestCase {
    
    var managedObjectContext: NSManagedObjectContext?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        managedObjectContext =  CoreDataStorage.shared.managedObjectContext()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // testing the initial entry of records before creating one
    func testCreateRecord() {
        do {
            let fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
            var pf = try managedObjectContext!.fetch(fetchRequest)
            XCTAssertEqual(pf[0].address, "")
            XCTAssertEqual(pf[0].email, "")
            XCTAssertEqual(pf[0].phone, "")
            XCTAssertEqual(pf[0].first_name, "")
            XCTAssertEqual(pf[0].last_name, "")
            
        } catch{
            print(error)
        }
        //
    }
    
    func testUpdateExistingRecord() {
        do {
            var fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
            var pr = try managedObjectContext!.fetch(fetchRequest)
            pr[0].setValue("Sainath", forKey: "first_name")
            fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
            var pf = try managedObjectContext!.fetch(fetchRequest)
            XCTAssertEqual(pf[0].first_name, "Sainath")
            
        } catch {
            print(error)
        }
    }
    
    func testRetrieveRecord() {
        do {
            let fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
            var pf = try managedObjectContext!.fetch(fetchRequest)
            pf[0].setValue("alphaRomeo", forKey: "first_name")
            XCTAssertEqual(pf[0].first_name, "alphaRomeo")
        } catch {
            print(error)
        }
    }
    
    
    
    func testDeleteRecord() {
        do {
            let fetchRequest = NSFetchRequest<ProfileData>(entityName: "ProfileData")
            var pf = try managedObjectContext!.fetch(fetchRequest)
            pf.remove(at: 0)
            XCTAssertEqual(pf[0].first_name, "")
        } catch {
            print(error)
        }
    }
    
}
