//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by vi20200225@wipro.com on 16/01/24.
//

import Foundation
import CoreLocation

class WeatherListViewModel : ObservableObject {
    
    @Published var forecasts: [WeatherViewModel] = []
    var location: String = ""
    
    func getWeatherForecast() {
        let apiService = APIManager.shared
        CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let lat = placemarks?.first?.location?.coordinate.latitude,
               let lon = placemarks?.first?.location?.coordinate.longitude {
            
                        apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=68ea24e258a52605338da3609fa2286b",
                                           dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIManager.APIError>) in

                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            self.forecasts = forecast.daily.map { WeatherViewModel(forecast: $0)}
                        }
                    case .failure(let apiError):
                        switch apiError {
                        case .error(let errorString):
                            print(errorString)
                        }
                    }
                }
            }
        }
    }
}
