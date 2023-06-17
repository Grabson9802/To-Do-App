//
//  TodoAppEndToEndTests.swift
//  TodoAppEndToEndTests
//
//  Created by Krystian Grabowy on 17/06/2023.
//

import XCTest

final class when_app_is_launched: XCTestCase {

    override func tearDown() {
        Springboard.deleteApp()
    }
    
    func test_should_not_display_any_tasks() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let taskList = app.tables["taskList"]
        XCTAssertEqual(0, taskList.cells.count)
    }
}

final class when_user_saves_a_new_task: XCTestCase {
    
    override func tearDown() {
        Springboard.deleteApp()
    }
    
    func test_should_be_able_to_display_task_successfully() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
        
        let taskList = app.collectionViews["taskList"]
        
        XCTAssertEqual(1, taskList.cells.count)
    }
    
    func test_display_error_message_for_duplicate_title_asks() {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
        
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        saveTaskButton.tap()
        
        let taskList = app.collectionViews["taskList"]
        
        XCTAssertEqual(1, taskList.cells.count)
        
        let messageText = app.staticTexts["messageText"]
        
        XCTAssertEqual(messageText.label, "Task is already added")
    }
}

final class when_user_deletes_a_new_task: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
    }
    
    override func tearDown() {
        Springboard.deleteApp()
    }
    
    func test_should_delete_task_successfully() {
        
        let tasklistCollectionView = app.collectionViews["taskList"]
        let cell = tasklistCollectionView.cells.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        cell.swipeLeft()
        tasklistCollectionView.buttons["Delete"].tap()
        
        XCTAssertFalse(cell.exists)
    }
}

final class when_user_mark_task_as_favorite: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let titleTextField = app.textFields["titleTextField"]
        titleTextField.tap()
        titleTextField.typeText("Mow the lawn")
        
        let saveTaskButton = app.buttons["saveTaskButton"]
        saveTaskButton.tap()
    }
    
    override func tearDown() {
        Springboard.deleteApp()
    }
    
    func test_should_displayed_updated_task_on_screen_as_favorite() {
        
        let tasklistCollectionView = app.collectionViews["taskList"]
        let cell = tasklistCollectionView.cells.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        cell.tap()
        
        app.images["favoriteImage"].tap()
        app.buttons["closeButton"].tap()
        
        XCTAssertTrue(cell.exists)
    }
}
