//
//  PAWeeklyWeatherForecast.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Foundation

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
  var id: String { return city }
  let city: String
  let data: PAWeatherForecastData
  let week: [PAWeatherForecast]?
}

