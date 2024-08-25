//
//  Current.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import Foundation

class Current: Codable {
    var temp_c : Float
    var is_day : Float
    var condition : Condition
    var vis_km : Float
    var humidity : Int
    var feelslike_c : Float
    var pressure_mb : Float
}
