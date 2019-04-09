//
//  TranslateService.swift
//  LeBaluchon
//
//  Created by XenoX on 07/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import Foundation

class TranslateService {
    static var shared = TranslateService()
    private init() { }

    private var session = URLSession(configuration: .default)
    private var task: URLSessionTask?

    private var token: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_CLIENT_TRANSLATE_SECRET") as? String ?? ""
    }

    private let endpoint: String = "https://translation.googleapis.com/language/translate/v2?key="

    init(session: URLSession) {
        self.session = session
    }

    func getTranslation(for text: String, callback: @escaping (Bool, Translate?) -> Void) {
        task?.cancel()

        let request = createRequest(text: text)

        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return callback(false, nil)
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    return callback(false, nil)
                }

                guard let translate = try? JSONDecoder().decode(Translate.self, from: data) else {
                    return callback(false, nil)
                }

                callback(true, translate)
            }
        })

        task?.resume()
    }

    private func createRequest(text: String) -> URLRequest {
        var request = URLRequest(url: URL(string: endpoint + token)!)
        request.httpMethod = "POST"
        request.httpBody = "q=\(text)&target=EN&format=text".data(using: .utf8)

        return request
    }
}
