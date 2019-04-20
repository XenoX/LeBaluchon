//
//  WeatherController.swift
//  LeBaluchon
//
//  Created by XenoX on 13/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import UIKit
import Foundation

class WeatherController: UIViewController {
    @IBOutlet weak var NYTempLabel: UILabel!
    @IBOutlet weak var ParisTempLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        WeatherService.shared.getWeather(for: "New%20York", callback: { (success, weather) in
            guard success, let weather = weather else {
                return self.presentAPIErrorAlert()
            }
            self.NYTempLabel.text = "\(Int(weather.main["temp"]?.rounded() ?? 10)) °C"
        })

        WeatherService.shared.getWeather(for: "Paris", callback: { (success, weather) in
            guard success, let weather = weather else {
                return self.presentAPIErrorAlert()
            }
            self.ParisTempLabel.text = "\(Int(weather.main["temp"]?.rounded() ?? 10)) °C"
        })
    }
}
