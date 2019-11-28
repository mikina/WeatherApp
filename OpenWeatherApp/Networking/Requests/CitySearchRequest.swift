import Foundation

struct CitySearchRequest: APIHandlerRequestProtocol {
  var endpoint: String
  var method: HTTPMethod
  var query: [String: String]?
  
  init(name: String) {
    
    var base = URLComponents(url: Environment.APIURL, resolvingAgainstBaseURL: false)!
    base.path = "/data/2.5/find"
    
    self.endpoint = base.url!.absoluteString
    self.method = .GET
    
    var items: [String: String] = [:]
    items["q"] = name
    items["APPID"] = Environment.APIKEY
    
    self.query = items
  }
}
