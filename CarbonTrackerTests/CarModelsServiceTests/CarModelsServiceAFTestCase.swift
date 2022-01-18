//
//  CarModelsServiceAFTestCase.swift
//  CarbonTrackerTests
//
//  Created by JEAN SEBASTIEN BRUNET on 17/1/22.
//

import XCTest
@testable import CarbonTracker

class CarModelsServiceAFTestCase: XCTestCase {

    func testGivenAttemptingToFetchCarModels_WhenReceivingCorrectDataWithNoErrorAndCorrectResponse_CompletionShouldPostSuccess() {
        let mockSession = MockCarMakeSession(mockResponse: MockResponse(response: CarModelsFakeResponseData.responseOK, data: CarModelsFakeResponseData.carModelCorrectData))
        let carModelsSession = CarModelServiceAF(session: mockSession)
        let expectation = XCTestExpectation(description: "Wait for Queue Change")
        carModelsSession.fetchCarModels(with: "doesntMatter") { result in
            guard case .success(let data) = result else {
                XCTFail("Test with correct data failed")
                return
            }
            XCTAssertEqual(data[0].data.attributes.name, "Testarossa")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.9)
    }
}
