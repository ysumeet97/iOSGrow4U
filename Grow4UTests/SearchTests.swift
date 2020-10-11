//
//  SearchTests.swift
//  Grow4UTests
//
//  Created by Sainath Reddy K on 10/10/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import XCTest
@testable import Grow4U

class SearchTests: XCTestCase {
    
    var searchResultModel: SearchResultModel?
    var searchViewModel: SearchViewModel?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.searchViewModel = SearchViewModel()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDownloadJsonData() {
        searchViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f82ee18302a837e9578059e"), isProduct: true)
        do{
            sleep(3)
        }
        XCTAssertFalse((self.searchViewModel?.jsonProducts.isEmpty)!)
    }
    
    func testGetJsonData() {
        searchViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f82ee18302a837e9578059e"), isProduct: true)
        do{
            sleep(3)
        }
        XCTAssertFalse((self.searchViewModel?.getJsonData().farms.isEmpty)!)
    }
    
    func testDownloadJsonDataException() {
        searchViewModel?.downloadJson(url: URL (string: "https://api.jsonbin.io/b/5f82ee18302a837e9578059e"), isProduct: true)
        XCTAssertFalse((self.searchViewModel?.jsonProducts.indices.contains(0))!)
    }
    
    func testGetJsonDataException() {
        XCTAssertFalse(((self.searchViewModel?.getJsonData().farms.indices.contains(0))!))
    }
    
}
