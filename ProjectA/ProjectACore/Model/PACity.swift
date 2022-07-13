//
//  PACity.swift
//  ProjectA
//
//  Created by Bilgehan ISIKLI on 7/11/22.
//

import CoreLocation

enum PACity: String, CaseIterable {
  case Cupertino
  case NewYork
  case Detroit
  case Miami
  case Seattle
  case Denver

  var location: CLLocationCoordinate2D {
    switch self {
    case .Cupertino:
      return CLLocationCoordinate2D(latitude: 37.3092, longitude: -122.0786)
    case .NewYork:
      return CLLocationCoordinate2D(latitude: 40.6971, longitude: -74.2598)
    case .Detroit:
      return CLLocationCoordinate2D(latitude: 42.3314, longitude: -83.0458)
    case .Miami:
      return CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918)
    case .Seattle:
      return CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321)
    case .Denver:
      return CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
    }
  }
}

struct PAWeatherCityData: Codable {
  let gridId: String
  let gridX: Float
  let gridY: Float
}
