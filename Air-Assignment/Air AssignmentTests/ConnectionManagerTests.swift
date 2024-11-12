//
//  ConnectionManagerTests.swift
//  Air AssignmentTests
//
//  Created by Tiago Inácio on 11/11/2024.
//

import XCTest
@testable import Air_Assignment

class NetworkManagerTests: XCTestCase {

    var mockURLSession: URLSessionMock!
    var connectionManager: ConnectionManager!

    override func setUp() {
        super.setUp()

        // Initialize the mock URL session and pass it to NetworkManager
        mockURLSession = URLSessionMock()
        connectionManager = ConnectionManager(session: mockURLSession)
    }
    
    /* NATIONS TESTS */

    // Test Success: Data is fetched and decoded successfully
    func testFetchNationPopulationDataSuccess() {
        let expectedData = NationPopulationResponseData(data: [
            NationPopulationData(population: 331097593, nation: "United States", year: "2022", id_nation: "")
        ])
        
        let mockResponse = MockURLResponse(data: try? JSONEncoder().encode(expectedData), response: nil, error: nil)
        mockURLSession.mockResponse = mockResponse

        let expectation = self.expectation(description: "Fetch population data success")

        connectionManager.fetchNationPopulationData(for: nil) { result in
            if case .success(let data) = result {
                XCTAssertEqual(data.data.count, 1)
                XCTAssertEqual(data.data[0].nation, "United States")
                XCTAssertEqual(data.data[0].population, 331097593)
                expectation.fulfill()
            } else {
                XCTFail("Expected success, but got failure")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test Network Error
    func testFetchNationPopulationDataNetworkFailure() {
        let mockResponse = MockURLResponse(data: nil, response: nil, error: ConnectionManagerError.internetConnectionError)

        mockURLSession.mockResponse = mockResponse

        let expectation = self.expectation(description: "Network failure")

        connectionManager.fetchNationPopulationData(for: nil) { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, "A network failure occurred, please check your internet connection.")
                expectation.fulfill()
            } else {
                XCTFail("Expected failure, but got success")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test Decoding Failure
    func testFetchNationPopulationDataDecodingFailure() {
        let invalidJson = "{ -- invalid json -- }"
        let mockResponse = MockURLResponse(data: invalidJson.data(using: .utf8), response: nil, error: nil)

        mockURLSession.mockResponse = mockResponse

        let expectation = self.expectation(description: "Decoding error.")

        connectionManager.fetchNationPopulationData(for: nil) { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, "Decoding error.")
                expectation.fulfill()
            } else {
                XCTFail("Expected decoding error, but got success")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test Empty Data Response
    func testFetchNationPopulationDataEmptyResponse() {
        let mockResponse = MockURLResponse(data: nil, response: nil, error: nil)

        mockURLSession.mockResponse = mockResponse

        let expectation = self.expectation(description: "No data was returned from the server.")

        connectionManager.fetchNationPopulationData(for: nil) { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, "No data was returned from the server.")
                expectation.fulfill()
            } else {
                XCTFail("Expected empty data, but got failure")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /* STATES TESTS */
    
    // Test Success: Data is fetched and decoded successfully
    func testFetchStatePopulationDataSuccess() {
        let expectedData = StatePopulationResponseData(data: [
            StatePopulationData(population: 5028092, state: "Alabama", year: "2022", id_state: "")
        ])
        
        let mockResponse = MockURLResponse(data: try? JSONEncoder().encode(expectedData), response: nil, error: nil)
        mockURLSession.mockResponse = mockResponse

        let expectation = self.expectation(description: "Fetch population data success")

        connectionManager.fetchStatePopulationData(for: nil) { result in
            if case .success(let data) = result {
                XCTAssertTrue(data.data.count > 0)
                XCTAssertEqual(data.data[0].state, "Alabama")
                XCTAssertEqual(data.data[0].population, 5028092)
                expectation.fulfill()
            } else {
                XCTFail("Expected success, but got failure")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test Network Error
    func testFetchStatePopulationDataNetworkFailure() {
        let mockResponse = MockURLResponse(data: nil, response: nil, error: ConnectionManagerError.internetConnectionError)

        mockURLSession.mockResponse = mockResponse

        let expectation = self.expectation(description: "Network failure")

        connectionManager.fetchStatePopulationData(for: nil) { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, "A network failure occurred, please check your internet connection.")
                expectation.fulfill()
            } else {
                XCTFail("Expected failure, but got success")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test Decoding Failure
    func testFetchStatePopulationDataDecodingFailure() {
        let invalidJson = "{ -- invalid json -- }"
        let mockResponse = MockURLResponse(data: invalidJson.data(using: .utf8), response: nil, error: nil)

        mockURLSession.mockResponse = mockResponse

        let expectation = self.expectation(description: "Decoding error.")

        connectionManager.fetchStatePopulationData(for: nil) { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, "Decoding error.")
                expectation.fulfill()
            } else {
                XCTFail("Expected decoding error, but got success")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }

    // Test Empty Data Response
    func testFetchStatePopulationDataEmptyResponse() {
        let mockResponse = MockURLResponse(data: nil, response: nil, error: nil)

        mockURLSession.mockResponse = mockResponse

        let expectation = self.expectation(description: "No data was returned from the server.")

        connectionManager.fetchStatePopulationData(for: nil) { result in
            if case .failure(let error) = result {
                XCTAssertEqual(error.localizedDescription, "No data was returned from the server.")
                expectation.fulfill()
            } else {
                XCTFail("Expected empty data, but got failure")
            }
        }

        waitForExpectations(timeout: 5, handler: nil)
    }
}

class URLSessionMock: URLSession {
    var mockResponse: MockURLResponse?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        // Simulate the behavior based on mockResponse
        if let mockResponse = mockResponse {
            completionHandler(mockResponse.data, mockResponse.response, mockResponse.error)
        }
        
        // Return a mock data task that you can check for resume() calls
        let dataTaskMock = URLSessionDataTaskMock()
        return dataTaskMock
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    var resumeCalled = false
    
    override func resume() {
        // Mark that resume was called
        resumeCalled = true
    }
}

class MockURLResponse {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}
