//
//  RemoteService.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import Foundation

protocol RemoteServiceProtocol {
    func getWeatherResponse(handler: @escaping (WeatherApiResponse) -> Void)
}

class RemoteService: RemoteServiceProtocol {
    func getWeatherResponse(handler: @escaping (WeatherApiResponse) -> Void) {
        // 1
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=255e3a3516364012afb160618242308&q=Cairo&days=3&aqi=yes&alerts=no")
        
        // 2
        let requset = URLRequest(url: url!)
        
        //3
        let session = URLSession(configuration: .default)
        
        //4
        let task = session.dataTask(with: requset) { data, response, error in
            guard let data = data else {return}
            
            do{
                let response = try JSONDecoder().decode(WeatherApiResponse.self, from: data)
                handler(response)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // 5
        task.resume()
    }
}
