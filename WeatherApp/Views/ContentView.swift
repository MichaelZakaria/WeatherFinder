//
//  ContentView.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        if let location = viewModel.location, let current = viewModel.current, let forecast = viewModel.forecast{
            
// Section 1 ##############################################
            NavigationStack {
                VStack {
                    VStack {
                        Text(location.name)
                        Text("\(Int( current.temp_c))°")
                        
                    }.font(.title).bold()
                    
                    VStack {
                        Text(current.condition.text)
                        Text("H: \(Int(forecast.forecastday[0].day.maxtemp_c))°  L: \(Int(forecast.forecastday[0].day.mintemp_c))°")
                    }.font(.title2)
                    
                    AsyncImage(url: URL(string: "https:\(current.condition.icon)") ) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 80, height: 80)
                                .offset(y: -20)
                        } else if phase.error != nil {
                            Image(systemName: "xmark.icloud")
                                .resizable()
                                .frame(width: 45, height: 35)
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal)
                                .padding(.vertical, 16)
                        } else {
                            ProgressView()
                        }
                    }
                    
                    Spacer()
                    
    // Section 2 ##############################################
                    VStack {
                            List(forecast.forecastday) { forecastDay in
                                VStack {
                                    if forecast.forecastday[0].date == forecastDay.date {
                                        Text("3-DAY FORECAST")
                                            .font(.caption)
                                            .frame(maxWidth: 220, alignment: .leading)
                                            .padding(.horizontal)
                                        Divider()
                                            .background(Color.gray)
                                            .frame(width: 220)
                                    }
                                    
                                    ZStack{
                                        NavigationLink(destination: HoursView(viewModel: viewModel, day: viewModel.getDayIndex(day: forecastDay), date: forecastDay.date)) {
                                            EmptyView()
                                        }.opacity(0)
                                        
                                        HStack{
                                            if forecast.forecastday[0].date == forecastDay.date {
                                                Text("Today")
                                            } else {
                                                Text(viewModel.getDayName(stringDate: forecastDay.date))
                                            }
                                            
                                            AsyncImage(url: URL(string: "https:\(forecastDay.day.condition.icon)") ) { phase in
                                                if let image = phase.image {
                                                    image
                                                        .resizable()
                                                        .frame(width: 60, height: 60)
                                                } else if phase.error != nil {
                                                    Image(systemName: "xmark.icloud")
                                                        .resizable()
                                                        .frame(width: 35, height: 25)
                                                        .aspectRatio(contentMode: .fit)
                                                        .padding(.horizontal)
                                                        .padding(.vertical, 16)
                                                } else {
                                                    ProgressView()
                                                }
                                            }
                                            
                                            Text(String(format:"%.1f° - %.1f°",  forecastDay.day.maxtemp_c, forecastDay.day.mintemp_c))
                                        }
                                        .frame(maxWidth: .infinity, alignment: .center)
                                    }
                                    
                                    
                                    if forecast.forecastday[2].date != forecastDay.date {
                                        Divider()
                                            .background(Color.gray)
                                            .frame(width: 220)
                                    }
                                }
                                .padding(.vertical, -5)
                                .listRowBackground(Color.clear)
                                .listSectionSeparator(.hidden)
                                .listRowSeparator(.hidden)
                            }
                            .onAppear(perform: {
                                
                            })
                            .listStyle(.plain)
                    }
                    .offset(y: -20)
                    .padding()
                    
                    Spacer()
                    
    // Section 3 ##############################################
                    HStack{
                        Spacer()
                        
                        VStack{
                            Text("VISIBILITY")
                            Text("\(Int(current.vis_km)) km")
                                .font(.title2).bold()
                                .padding(.bottom)
                            Text("FEELS LIKE")
                            Text("\(Int(current.feelslike_c))°")
                                .font(.title2).bold()
                                .padding(.bottom)
                        }
                        
                        Spacer()
                        
                        VStack{
                            Text("HUMIDITY")
                            Text("\(Int(current.humidity))%")
                                .font(.title2).bold()
                                .padding(.bottom)
                            Text("PRESSURE")
                            Text("\(Int(current.pressure_mb))")
                                .font(.title2).bold()
                                .padding(.bottom)
                        }
                        
                        Spacer()
                    }.padding()
                    
                }
                .foregroundColor(viewModel.isDay ? Color.black : Color.white)
                .background(Image(viewModel.isDay ? .morning2 : .night4).resizable().ignoresSafeArea().blur(radius: 5.0))
            }
        } else {
            ProgressView()
        }
    }
}

#Preview {
    ContentView()
}
