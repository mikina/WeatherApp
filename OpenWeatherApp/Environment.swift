import Foundation
import Keys

struct Environment {
  // API key, you can get it from https://openweathermap.org/ website.
  static let APIKEY = OpenWeatherAppKeys().apikey
  
  // URL to the Open weather API.
  static let APIURL = URL(string: "https://api.openweathermap.org")!
}
