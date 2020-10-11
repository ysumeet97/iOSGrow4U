//
//  HomeUITests.swift
//  Grow4UUITests
//
//  Created by Sainath Reddy on 11/10/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import XCTest
@testable import Grow4U

class HomeUITests: XCTestCase {
    var app: XCUIApplication!
    var viewController: UIViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
     
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    // app code
    
    
    // UI test code
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
    
    
    func testADataIsLoading() {
        let myTable = app.tables.matching(identifier: "myUniqueTableViewIdentifier")
        let cell = myTable.cells.element(matching: .cell, identifier: "myCell_0")
        cell.tap()
        XCTAssert(cell.accessibilityElementCount() > 0)
    }
    
    func testBLandscapeMode(){
        XCUIDevice.shared.orientation = .landscapeRight
        XCUIDevice.shared.orientation = .landscapeRight
        
        let app = XCUIApplication()
        let detail = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Vegetables"]/*[[".cells.staticTexts[\"Vegetables\"]",".staticTexts[\"Vegetables\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        
        detail.tap()
        
    }
    
    func testCBackToHome(){
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        let productNameSearchField = app.searchFields["Product Name"]
        productNameSearchField.tap()
        productNameSearchField.typeText("oran")
        let tablesQuery = app.tables
        let product = tablesQuery.staticTexts["Orange"]
        XCTAssertTrue(product.exists)
        
    }
    
    
    
    func testDBackToDetail(){
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 2).tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.buttons["editButton"].tap()
        XCTAssertTrue(app.textFields["lastNameTextField"].exists)
        scrollViewsQuery.textFields["lastNameTextField"].tap()
        scrollViewsQuery.textFields["lastNameTextField"].typeText("Yedula")
        app.buttons["Done"].tap()
        let scrollView = app.scrollViews.containing(.image, identifier:"profile_image").children(matching: .scrollView).element
        scrollView.tap()
        scrollView.swipeUp()
        scrollView.swipeUp()
        sleep(2)
        scrollViewsQuery.buttons["saveButton"].forceTapElement()
    }
}


