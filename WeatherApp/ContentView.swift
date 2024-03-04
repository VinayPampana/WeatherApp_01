//
//  ContentView.swift
//  WeatherApp
//
//  Created by vi20200225@wipro.com on 16/01/24.
//

import SwiftUI

struct ContentView: View {
   @StateObject private var WeatherListVM = WeatherListViewModel()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter Location", text: $WeatherListVM.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        WeatherListVM.getWeatherForecast()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }
                List(WeatherListVM.forecasts, id: \.day) { day in
                        VStack(alignment: .leading) {
                            Text(day.day)
                                .fontWeight(.bold)
                            HStack(alignment: .center) {
                                Image(systemName: "hourglass")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                                VStack(alignment: .leading) {
                                    Text(day.overview)
                                    HStack {
                                        Text(day.high)
                                        Text(day.low)
                                    }
                                    HStack {
                                        Text(day.clouds)
                                        Text(day.pop)
                                    }
                                    Text(day.humidity)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            .navigationTitle("Mobile Weather")
            .padding(.horizontal)
            }
//        VStack{
//           
//            Text("Los Angeles")
//                .font(.largeTitle)
//                .padding()
//            Text("25°")
//                .font(.system(size: 70))
//                .bold()
//            Text("⛈️")
//                .font(.largeTitle)
//                .padding()
//            Text("Clear Sky")
//        }
//        Spacer(minLength: 200)
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
