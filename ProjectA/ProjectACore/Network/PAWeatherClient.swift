//
//  PAWeatherFetcher.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Combine
import CoreLocation
import SwiftUI

enum PAWeatherFetchingError: Error, LocalizedError {
  case urlError
  case noData
}

class PAWeatherClient {
  
  internal struct PAWeatherClientContainer<NWSAPIData: Codable>: Codable {
    let properties: NWSAPIData
  }
  
  func fetchDefaultCities() -> AnyPublisher<[PAWeatherForecast], Error> {
    let publishers = PACity.allCases.publisher.flatMap { city in
      return self.fetchCityData(location: city.location)
        .flatMap({ self.fetchWeatherData(cityData: $0) })
        .map({ PAWeatherForecast(city: city.rawValue,
                                 data: $0.periods.first!,
                                 week: $0.periods.map({ PAWeatherForecast(city: city.rawValue, data: $0, week:nil) }))})
    }
    return Publishers.MergeMany(publishers).collect().eraseToAnyPublisher()
  }
  
  func fetchCityData(location: CLLocationCoordinate2D) -> Future<PAWeatherCityData, Error> {
    return genericFetcher(endpoint: "https://api.weather.gov/points/\(String(format: "%.4f", location.latitude)),\(String(format: "%.4f", location.longitude))")
  }
  
  func fetchWeatherData(cityData: PAWeatherCityData) -> Future<PAWeeklyWeatherForecastData, Error> {
    return genericFetcher(endpoint: "https://api.weather.gov/gridpoints/\(cityData.gridId)/\(cityData.gridX),\(cityData.gridY)/forecast")
  }
  
  func genericFetcher<Data:Codable>(endpoint: String) -> Future<Data, Error> {
    return Future<Data, Error> { promise in
      guard let url = URL(string: endpoint) else {
          promise(.failure(PAWeatherFetchingError.urlError))
          return
      }
      let urlRequest = URLRequest(url: url)
      let task = URLSession.shared.dataTask(with: urlRequest) {
          (data, response, error) in
          guard let responseData = data else {
            promise(.failure(PAWeatherFetchingError.noData))
            return
          }
          guard error == nil else {
            promise(.failure(error!))
            return
          }
          let decoder = JSONDecoder()
          do {
            let genericData = try decoder.decode(PAWeatherClientContainer<Data>.self, from: responseData)
            promise(.success(genericData.properties))
          } catch (let error) {
            promise(.failure(error))
          }
      }
      task.resume()
    }
  }
}
