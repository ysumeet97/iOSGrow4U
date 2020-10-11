//
//  SearchUITests.swift
//  Grow4UUITests
//
//  Created by Sumeet Yedula on 11/10/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import XCTest

class SearchUITests: XCTestCase {
    var app: XCUIApplication?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        app = XCUIApplication()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testIsNavBarConatainingTheSearchIcon () {
        let searchIcon = app?.tabBars.buttons["tabSearchIcon"]
        XCTAssertNotNil(searchIcon)
    }
    
    func testViewDetailsPage (){
        let app = XCUIApplication()
        let tabBarButton = app.tabBars.children(matching: .button).element(boundBy: 1)
        XCTAssertTrue(tabBarButton.exists)
        tabBarButton.tap()
        let detailsButton =  app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Apple")/*[[".cells.containing(.staticText, identifier:\"Apple\")",".cells.containing(.staticText, identifier:\"Price: 20$ \/ Kg\")"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.buttons["list item button"]
        XCTAssertTrue(detailsButton.exists)
        detailsButton.tap()
        let detailsPage = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
       XCTAssertTrue(detailsPage.exists)
        
    }
    
    func testNoProductsOnSearch() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        let productNameSearchField = app.searchFields["Product Name"]
        productNameSearchField.tap()
        productNameSearchField.typeText("inavlidsearch")
        let emptyListTable = app.tables["Empty list"]
        XCTAssertTrue(emptyListTable.exists)
    }
    
    func testNoProductsOnSearchClearsOnClearButton() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        let productNameSearchField = app.searchFields["Product Name"]
        productNameSearchField.tap()
        productNameSearchField.typeText("inavlidsearch")
        let emptyListTable = app.tables["Empty list"]
        XCTAssertTrue(emptyListTable.exists)
        productNameSearchField.buttons["Clear text"].tap()
        let tablesQuery = app.tables
        let product = tablesQuery.staticTexts["Apple"]
        XCTAssertTrue(product.exists)
    }
    
    func testValidSearch () {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        let productNameSearchField = app.searchFields["Product Name"]
        productNameSearchField.tap()
        productNameSearchField.typeText("oran")
        let tablesQuery = app.tables
        let product = tablesQuery.staticTexts["Orange"]
        XCTAssertTrue(product.exists)
    }
    
    func testButtonWidth() {
        let app = XCUIApplication()
        let tabBarButton = app.tabBars.children(matching: .button).element(boundBy: 1)
        XCTAssertTrue(tabBarButton.exists)
        tabBarButton.tap()
        let detailsButton =  app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Apple")/*[[".cells.containing(.staticText, identifier:\"Apple\")",".cells.containing(.staticText, identifier:\"Price: 20$ \/ Kg\")"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.buttons["list item button"]
        XCTAssertEqual(detailsButton.frame.width, 50)
    }
    
    func testIsDisplayingImageOnLandscape() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        let detailsButton =  app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Apple")/*[[".cells.containing(.staticText, identifier:\"Apple\")",".cells.containing(.staticText, identifier:\"Price: 20$ \/ Kg\")"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.buttons["list item button"]
        detailsButton.tap()
        XCUIDevice.shared.orientation = .landscapeRight
        let prodImage = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        XCTAssertTrue(prodImage.exists)
    }
    
    
    func testBackButton() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        let detailsButton =  app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Apple")/*[[".cells.containing(.staticText, identifier:\"Apple\")",".cells.containing(.staticText, identifier:\"Price: 20$ \/ Kg\")"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.buttons["list item button"]
        detailsButton.tap()
        app.navigationBars["Grow4U.ProductInfoView"].buttons["Back"].tap()
        let searchTitle = app.navigationBars["Search"].otherElements["Search"]
        XCTAssertTrue(searchTitle.exists)
    }
}
