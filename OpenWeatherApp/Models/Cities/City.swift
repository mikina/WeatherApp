//  swiftlint:disable identifier_name

import Foundation

struct City: Codable {
  let id: Int
  let name: String
  let main: CityTemp?
  let sys: CityCountry?
  let weather: [CityWeather]?
}
