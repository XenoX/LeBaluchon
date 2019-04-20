//
//  TranslateServiceTests.swift
//  LeBaluchonTests
//
//  Created by XenoX on 20/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import XCTest
@testable import LeBaluchon

class TranslateServiceTests: XCTestCase {

    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translateService = TranslateService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translateService.getTranslation(for: "Bonjour", callback: { (success, translate) in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translateService = TranslateService(session: URLSessionFake(data: nil, response: nil, error: nil))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translateService.getTranslation(for: "Bonjour", callback: { (success, translate) in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translateService = TranslateService(session: URLSessionFake(
            data: FakeResponseData.translateCorrectData,
            response: FakeResponseData.responseKO,
            error: nil
        ))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translateService.getTranslation(for: "Bonjour", callback: { (success, translate) in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let translateService = TranslateService(session: URLSessionFake(
            data: FakeResponseData.incorrectData,
            response: FakeResponseData.responseOK,
            error: nil
        ))

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translateService.getTranslation(for: "Bonjour", callback: { (success, translate) in
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translateService = TranslateService(session: URLSessionFake(
            data: FakeResponseData.translateCorrectData, response: FakeResponseData.responseOK, error: nil)
        )

        let expectation = XCTestExpectation(description: "Wait for queue change.")

        translateService.getTranslation(for: "Bonjour", callback: { (success, translate) in
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)

            XCTAssertEqual("Hello", translate!.data.translations[0].translatedText)

            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 0.01)
    }
}
