//
//  RangeEntry_ExampleUITests.swift
//  RangeEntry_ExampleUITests
//
//  Created by Fitsyu  on 16/06/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest

class RangeEntry_ExampleUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false

        XCUIApplication().launch()
    }

//    - minimum can be set
//    - maximum can be set
//    - when minimum is set **above** maximum, maximum is set equal to minimum
//    - when maximum is set **below** minimum, minimum is set equal to maximum
//    - when minimum or maximum is set **negative**, it is set to **zero**
//    - when minimum or maximum is set, slider thumbs are updated
//    - when slider thumbs slides, it is reflected on its respective value

    func testMinimumCanBeSet() {
        
        let app = XCUIApplication()
        
        // get the minimum textField
        let minimumTextField = app.textFields["startValue"]
        
        // edit it by opening the input keyboard
        minimumTextField.tap()
        
        // clear (assume there is value of "10")
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey.tap()
        deleteKey.tap()
        
        // set it to 1_000
        let key1 = app.keys["1"]
        key1.tap()
        
        let key0 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key0.tap()
        key0.tap()
        key0.tap()
        
        // close the input
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // verify
        let priceRangeLabel = app.staticTexts["min:1000 max:40000000"]
        let exists = priceRangeLabel.waitForExistence(timeout: 1)
        
        XCTAssertTrue(exists, "when minimum is set to 1000, it is reflected on the label")
    }
    
    func testMaximumCanBeSet() {
        
        let app = XCUIApplication()
        
        // get the minimum textField
        let maximumTextField = app.textFields["endValue"]
        
        // edit it by opening the input keyboard
        maximumTextField.tap()
        
        // clear (assume there is value of "40.000.000")
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let fortyMillionChars = "40.000.000"
        fortyMillionChars.forEach { _ in deleteKey.tap() }
        
        
        // set it to 1_000
        let key1 = app.keys["1"]
        key1.tap()
        
        let key0 = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key0.tap()
        key0.tap()
        key0.tap()
        
        // close the input
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // verify
        let priceRangeLabel = app.staticTexts["min:10 max:1000"]
        let exists = priceRangeLabel.waitForExistence(timeout: 1)
        
        XCTAssertTrue(exists, "when maximum is set to 1000, it is reflected on the label")
    }

    func test_when_minimum_set_ABOVE_maximum_maximum_is_set_equal_to_minimum() {
        
        let app = XCUIApplication()
        
        // get the minimum textField
        let minimumTextField = app.textFields["startValue"]
        
        // edit it by opening the input keyboard
        minimumTextField.tap()
        
        // clear one char (assume there is value of "10")
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey.tap()
        deleteKey.tap()
        
        // set it to 40_000_001 (+1 more)
        let fortyMillionAndOne = "40000001"
        fortyMillionAndOne.forEach { app.keys["\($0)"].tap() }
        
        // close the input
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // verify
        let priceRangeLabel = app.staticTexts["min:40000001 max:40000001"]
        let exists = priceRangeLabel.waitForExistence(timeout: 1)
        
        XCTAssertTrue(exists, "when minimum is set above maximum, maximum is set equal to minimum")
    }
    
    func test_when_maximum_set_BELOW_minimum_minimum_is_set_equal_to_maximum() {
        
        let app = XCUIApplication()
        
        // get the minimum textField
        let maximumTextField = app.textFields["endValue"]
        
        // edit it by opening the input keyboard
        maximumTextField.tap()
        
        // clear (assume there is value of "40.000.000")
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["Delete"]/*[[".keyboards.keys[\"Delete\"]",".keys[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let fortyMillionChars = "40.000.000"
        fortyMillionChars.forEach { _ in deleteKey.tap() }
        
        // set it to 5 (it is less than 10)
        app.keys["5"].tap()
        
        // close the input
        app.toolbars["Toolbar"].buttons["Done"].tap()
        
        // verify
        let priceRangeLabel = app.staticTexts["min:5 max:5"]
        let exists = priceRangeLabel.waitForExistence(timeout: 1)
        
        XCTAssertTrue(exists, "when maximum is set below minimum, minimum is set equal to maximum")
    }
}
