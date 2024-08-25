//
//  HoursView.swift
//  WeatherApp
//
//  Created by Marco on 2024-08-24.
//

import SwiftUI

struct HoursView: View {
    @ObservedObject var viewModel : WeatherViewModel
    private var day : Int
    private var date : String
    
    init(viewModel: WeatherViewModel, day: Int, date: String) {
        self.viewModel = viewModel
        self.day = day
        self.date = date
    }
    
    var body: some View {
        if viewModel.forecast != nil{
            VStack {
                
                Text( day == 0 ? "Today" : viewModel.getDayName(stringDate: date)).font(.largeTitle).bold()
                
                List(viewModel.getRemainigHoursArr(day: day)) { hour in
                    HStack{
                        Spacer()
                        
                        let hourTime = viewModel.getCurrentHour(date: viewModel.getDateFromString(stringDate: hour.time))
                        
                        if viewModel.getCurrentHour() == hourTime && day == 0 {
                            Text("Now")
                                .font(.largeTitle)
                                .shadow(radius: 10)
                                .bold()
                        } else if hourTime == 0 {
                            Text("12AM").font(.title)
                        } else if hourTime < 12 {
                            Text("\(hourTime)AM").font(.title)
                        } else if hourTime == 12 {
                            Text("\(hourTime)PM").font(.title)
                        } else {
                            Text("\(hourTime - 12)PM").font(.title)
                        }
                        
                        Spacer()
                        
                        AsyncImage(url: URL(string: "https:\(hour.condition.icon)") ) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .frame(width: 80, height: 80)
                            } else if phase.error != nil {
                                Image(systemName: "xmark.icloud")
                                    .resizable()
                                    .frame(width: 40, height: 30)
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal)
                                    .padding(.vertical, 16)
                            } else {
                                ProgressView()
                            }
                        }
                        
                        Spacer()
                        
                        Text("\(Int(hour.temp_c))°").font(.title)
                        
                        Spacer()
                    }
                    .padding(.vertical, -10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
            }
            .foregroundColor(viewModel.isDay ? Color.black : Color.white)
            .background(Image(viewModel.isDay ? .morning2 : .night4).resizable().ignoresSafeArea().blur(radius: 5.0))
        } else {
            ProgressView()
        }
        
    }
}

#Preview {
    HoursView( viewModel: WeatherViewModel(), day: 1, date: "Date")
}
