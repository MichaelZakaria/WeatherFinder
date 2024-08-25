//
//  ContentViewViewModel.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    var remoteService: RemoteServiceProtocol?
    
    var formatter : DateFormatter
    
    var isDay : Bool = true
    
    @Published var location : Location?
    @Published var current : Current?
    @Published var forecast : Forecast?
    
    init() {
       remoteService = RemoteService()
       formatter = DateFormatter()
        
        if getCurrentHour() > 5 && getCurrentHour() < 18 {
            isDay = true
        } else {
            isDay = false
        }
        
       setWeatherInfo()
    }
    
    func getDayIndex(day: ForecastDay) -> Int{
        return forecast?.forecastday.firstIndex(where: {$0.date == day.date}) ?? 0
    }
    
    func setWeatherInfo() {
        remoteService?.getWeatherResponse(handler: { weatherResponse in
            DispatchQueue.main.async {
                self.location = weatherResponse.location
                self.current = weatherResponse.current
                self.forecast = weatherResponse.forecast
            }
        })
    }
    
    func getDayName(stringDate: String) -> String{
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: stringDate) else {return "Random Day"}
        
        formatter.dateFormat = "EEE"
        
        return formatter.string(from: date)
    }
    
    func getCurrentHour(date: Date = Date()) -> Int{
        formatter.dateFormat = "HH"
        
        return Int(formatter.string(from: date))!
    }
    
    func getDateFromString(stringDate: String) -> Date {
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: stringDate)!
    }
    
    func getRemainigHoursArr(day: Int) -> [Hour] {
        var hoursArr : [Hour] = []
        
        guard let forecastday = forecast?.forecastday[day] else {
            return hoursArr
        }
        
        var hour = day == 0 ? getCurrentHour() : 0
        while hour < 24 {
            hoursArr.append(forecastday.hour[hour])
            hour+=1
        }
        
        return hoursArr
    }
}
