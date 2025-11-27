//
//  APIServiceTests.swift
//  AppStarterKit(MVVM+SwiftData)
//
//  Created by Sopnil Sohan on 27/11/25.
//

import XCTest

final class APIServiceTests: XCTestCase {
    var apiService: APIService!
    
    override func setUp() {
        super.setUp()
        // Use a mock base URL for testing
        apiService = APIService(baseURL: "https://api.example.com")
    }
    
    override func tearDown() {
        apiService = nil
        super.tearDown()
    }
    
    func testAPIServiceInitialization() {
        // Given & When: API Service is initialized
        // Then: It should not be nil
        XCTAssertNotNil(apiService, "API Service should be initialized")
    }
    
    func testInvalidURL() async {
        // Given: An invalid endpoint
        let invalidEndpoint = ""
        
        // When: Fetch is called with invalid URL
        let result: Result<TestModel, AppError> = await apiService.fetch(invalidEndpoint)
        
        // Then: It should return a network error
        switch result {
        case .failure(let error):
            if case .networkError = error {
                XCTAssertTrue(true, "Should return network error for invalid URL")
            } else {
                XCTFail("Expected network error")
            }
        case .success:
            XCTFail("Should not succeed with invalid URL")
        }
    }
}

// MARK: - Test Model
struct TestModel: Codable {
    let id: Int
    let name: String
}

