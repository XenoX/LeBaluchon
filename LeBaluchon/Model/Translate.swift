//
//  Translate.swift
//  LeBaluchon
//
//  Created by XenoX on 07/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import Foundation

struct Translate: Decodable {
    let data: Translations
}

struct Translations: Decodable {
    let translations: [Translated]
}

struct Translated: Decodable {
    let translatedText: String
}
