//
//  PAWeeklyWeatherForecast.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Foundation

enum PAWeatherUnit {
  case F
  case C
}

struct PAWeatherForecastData: Codable {
  let name: String
  let temperature: Float
  let icon: String
  let shortForecast: String
}

struct PAWeeklyWeatherForecastData : Codable {
  let periods: [PAWeatherForecastData]
}

struct PAWeatherForecast: Identifiable {
  var id: String { return city + "-" + data.name }
  let city: String
  let data: PAWeatherForecastData
  let week: [PAWeatherForecast]?
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
