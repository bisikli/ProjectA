//
//  PAWeeklyWeatherForecastData.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/12/22.
//

import Foundation

struct PAWeeklyWeatherForecastData : Codable {
  let periods: [PAWeatherForecastData]
}
