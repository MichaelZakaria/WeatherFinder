//
//  WeatherApiResponse.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import Foundation

class WeatherApiResponse: Codable {
    var location : Location
    var current : Current
    var forecast : Forecast
}
