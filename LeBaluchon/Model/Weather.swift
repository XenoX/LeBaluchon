//
//  Weather.swift
//  LeBaluchon
//
//  Created by XenoX on 13/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let name: String
    let coord: Dictionary<String, Float>
    let weather: [WeatherEmbed]
    let base: String
    let main: Dictionary<String, Float>
    let visibility: Float
    let wind: Dictionary<String, Float>
    let clouds: Dictionary<String, Float>
    let dt: Float
    let sys: Sys
}

struct WeatherEmbed: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct Sys: Decodable {
    let country: String
    let sunrise: Int
    let sunset: Int
}
