//
//  ToDo_withTestsUITests.swift
//  ToDo_withTestsUITests
//
//  Created by Emincan on 14.10.2022.
//

import XCTest

class ToDo_withTestsUITests: XCTestCase {

   

    func testToDoItem() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let addBtn = app.navigationBars["ToDo_withTests.View"].buttons["Add"]
        let elementsQuery = app.alerts["Add New Task"].scrollViews.otherElements
        let textField = app.alerts["Add New Task"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["Enter Task Here"]/*[[".cells.textFields[\"Enter Task Here\"]",".textFields[\"Enter Task Here\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let okBtn = elementsQuery.buttons["OK"]
        let addedCell = app.tables.cells.containing(.staticText, identifier:"my todo").element
        
        addBtn.tap()
        textField.tap()
        textField.typeText("my todo")
        okBtn.tap()
        
        XCTAssertTrue(addedCell.exists)
        
        
    }
    
    func testDeleteItem() throws {
        let app = XCUIApplication()
        app.launch()
        let addBtn = app.navigationBars["ToDo_withTests.View"].buttons["Add"]
        let elementsQuery = app.alerts["Add New Task"].scrollViews.otherElements
        let textField = app.alerts["Add New Task"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["Enter Task Here"]/*[[".cells.textFields[\"Enter Task Here\"]",".textFields[\"Enter Task Here\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let okBtn = elementsQuery.buttons["OK"]
        let addedCell = app.tables.cells.containing(.staticText, identifier:"my todo").element

        addBtn.tap()
        textField.tap()
        textField.typeText("my todo")
        okBtn.tap()
        
        
        
        let tablesQuery = app.tables
        let deleteBtn = tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells.buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        addedCell.swipeLeft()
        deleteBtn.tap()
        XCTAssertFalse(addedCell.exists)
        
    }

  
}
