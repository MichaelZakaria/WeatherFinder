//
//  ForecastDay.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import Foundation

class ForecastDay: Codable, Identifiable {
    var date: String
    var day: Day
    var hour: [Hour]
}
