//
//  Air_AssignmentUITests.swift
//  Air AssignmentUITests
//
//  Created by Tiago Inácio on 11/11/2024.
//

import XCTest

final class Air_AssignmentUITests: XCTestCase {
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    // Navigate between tabs
    func switchSegment(to segment: String) {
        let segmentButton = app.buttons[segment]
        XCTAssertTrue(segmentButton.exists)
        segmentButton.tap()
    }

    
    func testListPopulationData() {
        // Test for Nation
        switchSegment(to: "Nation")
        let nationDataLabel = app.staticTexts["United States"]
        XCTAssertTrue(nationDataLabel.exists)
        
        // Test for State
        switchSegment(to: "State")
        let stateDataLabel = app.staticTexts["Alaska"]
        XCTAssertTrue(stateDataLabel.exists)
    }
    
    func testNavigationTitle() {
        switchSegment(to: "State")
        XCTAssertTrue(app.navigationBars["States"].exists)
        
        switchSegment(to: "Nation")
        XCTAssertTrue(app.navigationBars["Nations"].exists)
    }
    
    //TO-DO: UITests need to be improved
}


