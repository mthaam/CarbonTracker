//
//  CarMakeServiceAFTestCase.swift
//  CarbonTrackerTests
//
//  Created by JEAN SEBASTIEN BRUNET on 16/1/22.
//

import XCTest
import Alamofire
@testable import CarbonTracker

class CarMakeServiceAFTestCase: XCTestCase {

    func testGivenAttemptingToFetchCarMakes_WhenReceivingCorrectDataWithNoErrorAndCorrectResponse_CompletionShouldPostSuccess() {
        let mockSession = MockCarMakeSession(mockResponse: MockResponse(response: CarMakesFakeResponseData.responseOK, data: CarMakesFakeResponseData.carMakeCorrectData))
        let carMakeSession = CarMakeServiceAF(session: mockSession)
        let expectation = XCTestExpectation(description: "Wait for Queue Change")
        carMakeSession.fetchCarMakes { result in
            guard case .success(let data) = result else {
                XCTFail("Test with correct data failed")
                return
            }
            XCTAssertEqual(data[0].data.id, "5f266411-5bb1-4b91-b044-9707426df630")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.9)
    }

}