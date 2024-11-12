//
//  Air_AssignmentTests.swift
//  Air AssignmentTests
//
//  Created by Tiago Inácio on 11/11/2024.
//

import XCTest
@testable import Air_Assignment

final class Air_AssignmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchStatePopulationData() {
        let expectation = self.expectation(description: "Fetch Population data by State")
            
        
        //test fetching States Population
        ConnectionManager().fetchStatePopulationData(for: nil){ result in
            switch result {
            case .success(let data):
                XCTAssertFalse(data.data.isEmpty, "Data should not be empty")
            case .failure(let error):
                XCTFail("Fetching population data by State failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
            
        waitForExpectations(timeout: 5, handler: nil)
        }
    
    func testFetchNationPopulationData() {
            let expectation = self.expectation(description: "Fetch Population data by Nation")
            
        //test fetching Nation Population
        ConnectionManager().fetchStatePopulationData(for: nil) { result in
            switch result {
            case .success(let data):
                XCTAssertFalse(data.data.isEmpty, "Data should not be empty")
            case .failure(let error):
                XCTFail("Fetching population by Nation data failed with error: \(error.localizedDescription)")
            }
            expectation.fulfill()
        }
            
        waitForExpectations(timeout: 5, handler: nil)
    }

}
