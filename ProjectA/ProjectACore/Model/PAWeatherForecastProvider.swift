//
//  PAWeatherProvider.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Combine
import SwiftUI

class PAWeatherForecastProvider: ObservableObject {
  @Published var cityForecasts = [PAWeatherForecast]()
  @Published var error: Error?
  
  private let client = PAWeatherClient()
  private var fetchHandle: AnyCancellable?
  init () {
    fetchHandle = client.fetchDefaultCities()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { [weak self] completion in
        switch completion {
        case .finished:
          break
        case .failure(let error):
          self?.error = error
        }
      }, receiveValue: { [weak self] forecasts in
        self?.cityForecasts = forecasts
    })
  }
}

