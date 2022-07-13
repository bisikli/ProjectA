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
  @State var preferFahreneight = true
  var body: some View {
    if let error = forecastProvider.error {
      Text("\(error.localizedDescription)")
    } else {
      List(forecastProvider.cityForecasts, children: \.week) { weather in
        PACityListItemView(cityWeather: weather, preferredUnit: preferFahreneight ? .F : .C)
      }.overlay(alignment: .bottomTrailing) {
        HStack {
          Spacer()
          Text("Unit :\(preferFahreneight ? "°F" : "°C")")
          Toggle("Unit :\(preferFahreneight ? "°F" : "°C")", isOn: $preferFahreneight).labelsHidden()
        }
      }
    }
  }
}

struct PACityListItemView: View {
  let cityWeather: PAWeatherForecast
  let preferredUnit: PAWeatherUnit
  var body: some View {
    return HStack {
      Text(cityWeather.city)
      Spacer()
      HStack {
        Text(cityWeather.data.shortForecast)
        Text(cityWeather.data.description(unit: preferredUnit))
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

