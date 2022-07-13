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
          let preferredUnit = "\(preferFahreneight ? "°F" : "°C")"
          Spacer()
          Text(preferredUnit)
          Toggle(preferredUnit, isOn: $preferFahreneight).labelsHidden()
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
      VStack(alignment: .leading) {
        Text(cityWeather.city).font(.title3)
        Text(cityWeather.data.name).font(.caption)
      }
      Spacer()
      Text(cityWeather.data.description(unit: preferredUnit)).font(.body)
      AsyncImage(url: URL(string: cityWeather.data.icon)!)
        .aspectRatio(contentMode: .fit)
        .frame(width: 50.0, height: 50.0)
        .clipShape(Circle())
    }
  }
}

struct PACityListView_Previews: PreviewProvider {
  static var previews: some View {
    PACityListView()
  }
}

