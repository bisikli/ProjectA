//
//  PAWeeklyWeatherForecast.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Foundation

struct PAWeatherForecast: Identifiable {
  var id: String { return city + "-" + data.name }
  let city: String
  let data: PAWeatherForecastData
  let week: [PAWeatherForecast]?
}
