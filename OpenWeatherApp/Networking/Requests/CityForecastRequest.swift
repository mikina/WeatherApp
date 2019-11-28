import Foundation

struct CityForecastRequest: APIHandlerRequestProtocol {
  var endpoint: String
  var method: HTTPMethod
  var query: [String: String]?
  
  init(cityID: Int) {
    
    var base = URLComponents(url: Environment.APIURL, resolvingAgainstBaseURL: false)!
    base.path = "/data/2.5/forecast"
    
    self.endpoint = base.url!.absoluteString
    self.method = .GET
    
    var items: [String: String] = [:]
    items["id"] = String(cityID)
    items["APPID"] = Environment.APIKEY
    
    self.query = items
  }
}
