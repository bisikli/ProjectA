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
          Color.orange
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

