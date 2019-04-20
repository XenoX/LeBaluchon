//
//  CurrencyServiceTest.swift
//  LeBaluchonTests
//
//  Created by XenoX on 19/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class CurrencyServiceTests: XCTestCase {

    func testGetCurrencyShouldPostFailedCallbackIfError() {
        let currencyService = CurrencyService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyService.getCurrency(callback: { (success, currency) in
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfNoData() {
        let currencyService = CurrencyService(session: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyService.getCurrency { (success, currency) in
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfIncorrectResponse() {
        let currencyService = CurrencyService(session: URLSessionFake(
            data: FakeResponseData.currencyCorrectData,
            response: FakeResponseData.responseKO,
            error: nil
        ))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyService.getCurrency { (success, currency) in
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostFailedCallbackIfIncorrectData() {
        let currencyService = CurrencyService(session: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil
        ))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyService.getCurrency { (success, currency) in
            XCTAssertFalse(success)
            XCTAssertNil(currency)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetCurrencyShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let base = "EUR"
        let rateUSD: Float = 1.12345

        let currencyService = CurrencyService(session: URLSessionFake(
            data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseOK, error: nil)
        )

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        currencyService.getCurrency { (success, currency) in
            XCTAssertTrue(success)
            XCTAssertNotNil(currency)

            XCTAssertEqual(base, currency!.base)
            XCTAssertEqual(rateUSD, currency!.rates["USD"])

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.01)
    }
}
