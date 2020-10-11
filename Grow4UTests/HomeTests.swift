//
//  HomeTests.swift
//  Grow4UTests
//
//  Created by Sainath Reddy K on 10/10/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import XCTest
@testable import Grow4U

class HomeTests: XCTestCase {
    
    var farmsViewModel: FarmsViewModel?
    var productsViewModel: ProductsViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        farmsViewModel = FarmsViewModel()
        productsViewModel = ProductsViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAFarmsDownloadJson() {
        farmsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3e3d302a837e95760f33/3"))
        do{
            sleep(3)
        }
        XCTAssertFalse((self.farmsViewModel?.farms_model.isEmpty)!)
    }
    
    func testBFarmsGetData() {
        farmsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3e3d302a837e95760f33/3"))
        do{
            sleep(3)
        }
        XCTAssertFalse((self.farmsViewModel?.getFarmsData().isEmpty)!)
    }
    
    func testCProductsDownloadJson() {
        productsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3dd97243cd7e824bfd61/5"))
        do{
            sleep(3)
        }
        XCTAssertFalse((self.productsViewModel?.jsonProducts.isEmpty)!)
    }
    
    func testDVegetableCount() {
        productsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3dd97243cd7e824bfd61/5"))
        do{
            sleep(3)
        }
        XCTAssertFalse(((self.productsViewModel?.getVegetableCount())!<1))
    }
    
    func testEFruitCount() {
        productsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3dd97243cd7e824bfd61/5"))
        do{
            sleep(3)
        }
        XCTAssertFalse(((self.productsViewModel?.getFruitsCount())!<1))
    }
    
    func testGGetAllVegetableData() {
        productsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3dd97243cd7e824bfd61/5"))
        do{
            sleep(3)
        }
        XCTAssertNotNil(productsViewModel?.getAllVegetableData())
    }
    
    
    func testHGetFruitData() {
        productsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3dd97243cd7e824bfd61/5"))
        do{
            sleep(3)
        }
        XCTAssertTrue((self.productsViewModel?.getVegetableData().isEmpty)!)
    }
    
    func testIRemoveAllData() {
        productsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3dd97243cd7e824bfd61/5"))
        do{
            sleep(3)
        }
        productsViewModel?.removeAllData()
        XCTAssertTrue((productsViewModel?.id.isEmpty)!)
        XCTAssertTrue((productsViewModel?.image_url.isEmpty)!)
        XCTAssertTrue((productsViewModel?.type.isEmpty)!)
        XCTAssertTrue((productsViewModel?.name.isEmpty)!)
        XCTAssertTrue((productsViewModel?.availability.isEmpty)!)
        XCTAssertTrue((productsViewModel?.max_quantity.isEmpty)!)
        XCTAssertTrue((productsViewModel?.description.isEmpty)!)
        XCTAssertTrue((productsViewModel?.price.isEmpty)!)
        XCTAssertTrue((productsViewModel?.unit.isEmpty)!)
        XCTAssertTrue((productsViewModel?.Currency.isEmpty)!)
        XCTAssertTrue((productsViewModel?.location.isEmpty)!)
        XCTAssertTrue((productsViewModel?.farmers.isEmpty)!)
        
    }
    
    func testJAllFruitData() {
        productsViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f7d3dd97243cd7e824bfd61/5"))
        do{
            sleep(3)
        }
        XCTAssertNotNil(productsViewModel?.getAllFruitsData())
    }
    
    
}
