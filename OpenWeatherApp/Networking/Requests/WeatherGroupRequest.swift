import Foundation

struct WeatherGroupRequest: APIHandlerRequestProtocol {
  var endpoint: String
  var method: HTTPMethod
  var query: [String: String]?
  
  init(cityIDs: [Int]) {
    
    var base = URLComponents(url: Environment.APIURL, resolvingAgainstBaseURL: false)!
    base.path = "/data/2.5/group"
    
    self.endpoint = base.url!.absoluteString
    self.method = .GET
    
    var items: [String: String] = [:]
    items["id"] = cityIDs.map({"\($0)"}).joined(separator: ",")
    items["APPID"] = Environment.APIKEY
    
    self.query = items
  }
}
