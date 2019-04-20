//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by XenoX on 13/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import Foundation

class WeatherService {
    static var shared = WeatherService()
    private init() { }

    private var session = URLSession(configuration: .default)
    private var task: URLSessionTask?

    private var token: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_CLIENT_WEATHER_SECRET") as? String ?? ""
    }

    private let endpoint: String = "https://api.openweathermap.org/data/2.5/weather?q="
    private let parameters: String = "&units=metric&appid="

    init(session: URLSession) {
        self.session = session
    }

    func getWeather(for city: String, callback: @escaping (Bool, Weather?) -> Void) {
        task = session.dataTask(with: URL(string: endpoint + city + parameters + token)!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("1")
                    return callback(false, nil)
                }

                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("2")
                    return callback(false, nil)
                }

                guard let weather = try? JSONDecoder().decode(Weather.self, from: data) else {
                    print("3")
                    return callback(false, nil)
                }

                callback(true, weather)
            }
        })

        task?.resume()
    }
}
