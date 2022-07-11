//
//  PAWeatherFetcher.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Combine
import SwiftUI

enum PAWeatherFetchingError: Error, LocalizedError {
  case urlError
  case noData
}

struct NWSAPIContainer<NWSAPIData: Codable>: Codable {
  let properties: NWSAPIData
}

struct PAWeeklyWeatherForecast: Codable, Identifiable {
  struct PAWeatherForecast: Codable {
    let temperature: Float
  }
  let id: String = UUID().uuidString
  let periods: [PAWeatherForecast]
}

class PAWeatherClient {
  func fetchWeather(office: String, x: String, y: String) -> Future<PAWeeklyWeatherForecast, Error> {
    return Future<PAWeeklyWeatherForecast, Error> { promise in
      let endpoint = "https://api.weather.gov/gridpoints/\(office)/\(x),\(y)/forecast"
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
            let weatherData = try decoder.decode(NWSAPIContainer<PAWeeklyWeatherForecast>.self, from: responseData)
            promise(.success(weatherData.properties))
          } catch (let error) {
            promise(.failure(error))
          }
      }
      task.resume()
    }
  }
}

extension PAWeatherClient {
  func fetchSample() -> Future<PAWeeklyWeatherForecast, Error> {
    fetchWeather(office: "TOP", x: "31", y: "80")
  }
}

class PAWeatherProvider: ObservableObject {
  @Published var cityForecasts = [PAWeeklyWeatherForecast]()
  @Published var error: Error?
  
  private let client = PAWeatherClient()
  private var fetchHandle: AnyCancellable?
  init () {
    fetchHandle = client.fetchSample()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          self?.error = error
        }
      }, receiveValue: { [weak self] forecast in
        self?.cityForecasts = [forecast]
    })
  }
  
}

