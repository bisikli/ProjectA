//
//  PACityListItemView.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/12/22.
//

import SwiftUI

struct PACityListItemView: View {
  let cityWeather: PAWeatherForecast
  let preferredUnit: PAWeatherUnit
  var isSubItem : Bool {
    cityWeather.week == nil
  }
  var body: some View {
    return VStack(alignment: .leading) {
      HStack {
        VStack(alignment: .leading) {
          if isSubItem {
            Text(cityWeather.data.name).font(.body)
          } else {
            Text(cityWeather.city).font(.title3).bold()
            Text(cityWeather.data.name).font(.caption)
          }
        }
        Spacer()
        Text(cityWeather.data.description(unit: preferredUnit)).font(.body)
        AsyncImage(url: URL(string: cityWeather.data.icon)!)
          .aspectRatio(contentMode: .fit)
          .frame(width: 50.0, height: 50.0)
          .clipShape(Circle())
      }
      Spacer()
      Text(isSubItem
           ? cityWeather.data.detailedForecast
           : cityWeather.data.shortForecast)
        .font(.footnote)
        .italic()
    }
  }
}
