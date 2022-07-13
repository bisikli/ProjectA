//
//  PACityListViewController.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import Combine
import SwiftUI

struct PACityListView: View {
  @ObservedObject var forecastProvider = PAWeatherForecastProvider()
  @State var preferFahreneight = true
  var body: some View {
    if let error = forecastProvider.error {
      Text("\(error.localizedDescription)")
    } else {
      if (forecastProvider.cityForecasts.isEmpty) {
        ProgressView()
          .progressViewStyle(.circular)
          .scaleEffect(2.0)
      } else {
        List(forecastProvider.cityForecasts, children: \.week) { weather in
          PACityListItemView(cityWeather: weather, preferredUnit: preferFahreneight ? .F : .C)
        }.overlay(alignment: .bottomTrailing) {
          HStack {
            let preferredUnit = "\(preferFahreneight ? "°F" : "°C")"
            Spacer()
            Text(preferredUnit)
            Toggle(preferredUnit, isOn: $preferFahreneight)
              .labelsHidden()
              .padding()
          }
        }
      }
    }
  }
}

struct PACityListView_Previews: PreviewProvider {
  static var previews: some View {
    PACityListView()
  }
}

