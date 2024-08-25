//
//  Hour.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import Foundation

class Hour: Codable, Identifiable {
    var time: String
    var temp_c: Float
    var is_day: Int
    var condition: Condition
    var pressure_mb: Float
    var humidity: Int
    var vis_km: Float
    var feelslike_c: Float
}
