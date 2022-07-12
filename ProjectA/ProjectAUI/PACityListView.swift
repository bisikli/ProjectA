//
//  PACityListViewController.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Combine
import SwiftUI

struct PACityListView: View {
  @ObservedObject var forecastProvider = PAWeatherProvider()
  var body: some View {
    if let error = forecastProvider.error {
      Text("\(error.localizedDescription)")
    } else {
      List {
        ForEach(forecastProvider.cityForecasts) { cityForecast in
          PACityListItemView(cityWeather: cityForecast)
        }
      }
    }
  }
}

struct PACityListItemView: View {
  let cityWeather: PAWeeklyWeatherForecast
  var body: some View {
    let periodData = cityWeather.data.periods.first!
    return HStack {
      Text(cityWeather.city)
      Spacer()
      HStack {
        Text(periodData.shortForecast)
        Text("\(Int(periodData.temperature))")
        AsyncImage(url: URL(string: periodData.icon)!)
          .clipShape(Circle())
      }
    }
  }
}

struct PACityListView_Previews: PreviewProvider {
  static var previews: some View {
    PACityListView()
  }
}

