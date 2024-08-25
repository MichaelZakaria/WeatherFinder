//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import SwiftUI
import Alamofire

@main
struct WeatherAppApp: App {
    let reachabilityManager = NetworkReachabilityManager()
    
    var body: some Scene {
        WindowGroup {
            if reachabilityManager!.isReachable {
                ContentView()
            } else {
                Text("NO CONNECTION 🛜").opacity(0.5)
            }
        }
    }
}
