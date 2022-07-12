//
//  PAWeeklyWeatherForecast.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Foundation

struct PAWeeklyWeatherForecast: Identifiable {
  var id: String { return city }
  let city: String
  let data: PAWeeklyWeatherForecastData
}

struct PAWeeklyWeatherForecastData : Codable {
  struct PAWeatherForecast: Codable {
    let temperature: Float
  }
  let periods: [PAWeatherForecast]
}
