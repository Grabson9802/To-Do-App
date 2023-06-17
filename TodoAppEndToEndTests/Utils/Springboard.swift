//
//  Springboard.swift
//  TodoAppEndToEndTests
//
//  Created by Krystian Grabowy on 17/06/2023.
//

import Foundation
import XCTest

class Springboard {
    
    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    class func deleteApp() {
        
        XCUIApplication().terminate()
        springboard.activate()
        
        let appIcon = springboard.icons.matching(identifier: "ToDo").firstMatch
        appIcon.press(forDuration: 1.3)
        
        let _ = springboard.alerts.buttons["Remove App"].waitForExistence(timeout: 1.0)
        springboard.buttons["Remove App"].tap()
        
        let deleteButton = springboard.alerts.buttons["Delete App"].firstMatch
        if deleteButton.waitForExistence(timeout: 5.0) {
            deleteButton.tap()
            
            springboard.alerts.buttons["Delete"].tap()
        }
    }
}
