//
//  Currency.swift
//  LeBaluchon
//
//  Created by XenoX on 06/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    let timestamp: Int
    let base: String
    let date: String
    let rates: Dictionary<String, Float>
}
