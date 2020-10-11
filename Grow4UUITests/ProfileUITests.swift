//
//  ProfileUITests.swift
//  Grow4UUITests
//
//  Created by Sumeet Yedula on 11/10/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import XCTest

class ProfileUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAFirstNameTextField() {
        let app = XCUIApplication()
        sleep(2)
        app.tabBars.children(matching: .button).element(boundBy: 2).tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.buttons["editButton"].tap()
        XCTAssertTrue(app.textFields["firstNameTextField"].exists)
        scrollViewsQuery/*@START_MENU_TOKEN@*/.textFields["firstNameTextField"]/*[[".textFields[\"Ex: John\"]",".textFields[\"firstNameTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        scrollViewsQuery/*@START_MENU_TOKEN@*/.textFields["firstNameTextField"]/*[[".textFields[\"Ex: John\"]",".textFields[\"firstNameTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Sumeet")
        app/*@START_MENU_TOKEN@*/.buttons["Done"]/*[[".keyboards.buttons[\"Done\"]",".buttons[\"Done\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let scrollView = app/*@START_MENU_TOKEN@*/.scrollViews.containing(.image, identifier:"profile_image")/*[[".scrollViews.containing(.button, identifier:\"image_edit\")",".scrollViews.containing(.image, identifier:\"profile_image\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.children(matching: .scrollView).element
        scrollView.tap()
        scrollView.swipeUp()
        scrollView.swipeUp()
        sleep(2)
        scrollViewsQuery/*@START_MENU_TOKEN@*/.buttons["saveButton"]/*[[".buttons[\"Save\"]",".buttons[\"saveButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.forceTapElement()
        
    }
    
    func testBLastNameTextField() {
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
    
    func testCEmailTextField() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 2).tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.buttons["editButton"].tap()
        XCTAssertTrue(app.textFields["emailTextField"].exists)
        scrollViewsQuery.textFields["emailTextField"].tap()
        scrollViewsQuery.textFields["emailTextField"].typeText("a@gh.com")
        app.buttons["Done"].tap()
        let scrollView = app.scrollViews.containing(.image, identifier:"profile_image").children(matching: .scrollView).element
        scrollView.tap()
        scrollView.swipeUp()
        sleep(2)
        scrollViewsQuery.buttons["saveButton"].forceTapElement()
        
    }
    
    func testDPhoneTextField() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 2).tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.buttons["editButton"].tap()
        XCTAssertTrue(app.textFields["phoneTextField"].exists)
        scrollViewsQuery.textFields["phoneTextField"].tap()
        scrollViewsQuery.textFields["phoneTextField"].typeText("2345678")
        app.buttons["Done"].tap()
        let scrollView = app.scrollViews.containing(.image, identifier:"profile_image").children(matching: .scrollView).element
        scrollView.tap()
        scrollView.swipeUp()
        scrollView.swipeUp()
        sleep(2)
        scrollViewsQuery.buttons["saveButton"].forceTapElement()
        
    }
    
    func testEAddressTextField() {
        let app = XCUIApplication()
        app.tabBars.children(matching: .button).element(boundBy: 2).tap()
        
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.buttons["editButton"].tap()
        XCTAssertTrue(app.textFields["addressTextField"].exists)
        scrollViewsQuery.textFields["addressTextField"].tap()
        scrollViewsQuery.textFields["addressTextField"].typeText("14 Forks Avenue")
        app.buttons["Done"].tap()
        let scrollView = app.scrollViews.containing(.image, identifier:"profile_image").children(matching: .scrollView).element
        scrollView.tap()
        scrollView.swipeUp()
        scrollView.swipeUp()
        scrollView.swipeUp()
        sleep(3)
        scrollViewsQuery.buttons["saveButton"].forceTapElement()
        
    }
    
    
}


extension XCUIElement {
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        }
        else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx:0.0, dy:0.0))
            coordinate.tap()
        }
    }
}
