//  swiftlint:disable identifier_name

import Foundation

struct Forecast: Codable {
  let main: ForecastTemp
  let weather: [ForecastWeather]?
  let dt: Date
}
