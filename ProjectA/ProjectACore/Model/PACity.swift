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

  var location: CLLocationCoordinate2D {
    switch self {
    case .Cupertino:
      return CLLocationCoordinate2D(latitude: 37.3092448, longitude: -122.0786639)
    case .NewYork:
      return CLLocationCoordinate2D(latitude: 40.6971494, longitude: -74.2598633)
    }
  }
}

struct PAWeatherCityData: Codable {
  let gridId: String
  let gridX: Float
  let gridY: Float
}
