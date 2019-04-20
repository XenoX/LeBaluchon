//
//  CurrencyFakeResponseData.swift
//  LeBaluchonTests
//
//  Created by XenoX on 19/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Fixer", withExtension: "json")!

        return (try? Data(contentsOf: url)) ?? Data()
    }

    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "GoogleTranslate", withExtension: "json")!

        return (try? Data(contentsOf: url)) ?? Data()
    }

    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "OpenWeatherMap", withExtension: "json")!

        return (try? Data(contentsOf: url)) ?? Data()
    }

    static let incorrectData = "error".data(using: .utf8)!

    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://google.com")!,
        statusCode: 200, httpVersion: nil, headerFields: nil)!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://google.com")!,
        statusCode: 500, httpVersion: nil, headerFields: nil)!

    // MARK: - Error
    class FakeError: Error {}
    static let error = FakeError()
}
