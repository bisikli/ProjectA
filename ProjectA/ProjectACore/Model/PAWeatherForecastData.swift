//
//  PAWeatherForecastData.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/12/22.
//

import Foundation

struct PAWeatherForecastData: Codable {
  let name: String
  let temperature: Float
  let icon: String
  let shortForecast: String
  let detailedForecast: String
}

extension PAWeatherForecastData {
  func description(unit: PAWeatherUnit) -> String {
    switch unit {
    case .F:
      return "\(Int(temperature)) °F"
    case .C:
      // Approximately ~
      return "\(Int((temperature - 30)/2)) °C"
    }
  }
}
