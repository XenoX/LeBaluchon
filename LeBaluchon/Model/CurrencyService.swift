//
//  CurrencyService.swift
//  LeBaluchon
//
//  Created by XenoX on 06/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import Foundation

class CurrencyService {
    static var shared = CurrencyService()
    private init() { }

    private var session = URLSession(configuration: .default)
    private var task: URLSessionTask?

    private var token: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_CLIENT_FIXER_SECRET") as? String ?? ""
    }

    private let endpoint: String = "http://data.fixer.io/api/latest?access_key="

    init(session: URLSession) {
        self.session = session
    }

    func getCurrency(callback: @escaping (Bool, Currency?) -> Void) {
        task?.cancel()

        task = session.dataTask(with: URL(string: endpoint + token)!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return callback(false, nil)
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil)
                }

                guard let currency = try? JSONDecoder().decode(Currency.self, from: data) else {
                    return callback(false, nil)
                }

                callback(true, currency)
            }
        })

        task?.resume()
    }
}
