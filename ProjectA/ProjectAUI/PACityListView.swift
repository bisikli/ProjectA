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
      List(forecastProvider.cityForecasts, children: \.week) { weather in
        PACityListItemView(cityWeather: weather)
      }
    }
  }
}

struct PACityListItemView: View {
  let cityWeather: PAWeatherForecast
  var body: some View {
    return HStack {
      Text(cityWeather.city)
      Spacer()
      HStack {
        Text(cityWeather.data.shortForecast)
        Text("\(Int(cityWeather.data.temperature))")
        AsyncImage(url: URL(string: cityWeather.data.icon)!)
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

