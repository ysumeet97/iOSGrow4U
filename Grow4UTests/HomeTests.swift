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
    let jsonUrl = "https://api.jsonbin.io/b/5f82ee18302a837e9578059e"
    let farmUrl = "https://api.jsonbin.io/b/5f82f1b0302a837e957807eb"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        farmsViewModel = FarmsViewModel()
        productsViewModel = ProductsViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAFarmsDownloadJson() {
        farmsViewModel?.downloadJson(url: URL (string: jsonUrl))
        do{
            sleep(3)
        }
        XCTAssertFalse((self.farmsViewModel?.farms_model.isEmpty)!)
    }
    
    func testBFarmsGetData() {
        farmsViewModel?.downloadJson(url: URL (string: jsonUrl))
        do{
            sleep(3)
        }
        XCTAssertFalse((self.farmsViewModel?.getFarmsData().isEmpty)!)
    }
    
    func testCProductsDownloadJson() {
        productsViewModel?.downloadJson(url: URL (string: jsonUrl))
        do{
            sleep(3)
        }
        XCTAssertFalse((self.productsViewModel?.jsonProducts.isEmpty)!)
    }
    
    func testDVegetableCount() {
        productsViewModel?.downloadJson(url: URL (string: jsonUrl))
        do{
            sleep(3)
        }
        XCTAssertFalse(((self.productsViewModel?.getVegetableCount())!<1))
    }
    
    func testEFruitCount() {
        productsViewModel?.downloadJson(url: URL (string: jsonUrl))
        do{
            sleep(3)
        }
        XCTAssertFalse(((self.productsViewModel?.getFruitsCount())!<1))
    }
    
    func testGGetAllVegetableData() {
        productsViewModel?.downloadJson(url: URL (string: jsonUrl))
        do{
            sleep(3)
        }
        XCTAssertNotNil(productsViewModel?.getVegetableData())
    }
    
    
    func testHGetFruitData() {
        productsViewModel?.downloadJson(url: URL (string: jsonUrl))
        do{
            sleep(3)
        }
        XCTAssertTrue((self.productsViewModel?.getVegetableData().isEmpty)!)
    }
    
   
    func testJAllFruitData() {
        productsViewModel?.downloadJson(url: URL (string: jsonUrl))
        do{
            sleep(3)
        }
        XCTAssertNotNil(productsViewModel?.getFruitData())
    }
    
    
}
