//
//  WeatherServiceTests.swift
//  LeBaluchonTests
//
//  Created by XenoX on 20/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class WeatherServiceTests: XCTestCase {

    func testGetWeatherShouldPostFailedCallbackIfError() {
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(for: "Paris", callback: { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(for: "Paris", callback: { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        let weatherService = WeatherService(session: URLSessionFake(
            data: FakeResponseData.weatherCorrectData,
            response: FakeResponseData.responseKO,
            error: nil
        ))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(for: "Paris", callback: { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        let weatherService = WeatherService(session: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil
        ))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(for: "Paris", callback: { (success, weather) in
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(session: URLSessionFake(
            data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil)
        )

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        weatherService.getWeather(for: "Paris", callback: { (success, weather) in
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)

            XCTAssertEqual(17.45, weather!.main["temp"])

            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }
}
