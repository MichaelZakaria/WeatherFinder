//
//  Day.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import Foundation

class Day: Codable {
    var maxtemp_c: Float
    var mintemp_c: Float
    var avgtemp_c: Float
    var condition: Condition
}
