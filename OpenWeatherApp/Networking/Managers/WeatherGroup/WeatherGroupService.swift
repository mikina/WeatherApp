import Foundation

protocol WeatherGroupServiceProtocol {
  func getWeatherGroup(cityIDs: [Int], completion: @escaping (Result<[City], Error>) -> Void)
}

class WeatherGroupService: WeatherGroupServiceProtocol {
  
  private let apiHandler: APIHandlerProtocol = resolve()
  
  func getWeatherGroup(cityIDs: [Int], completion: @escaping (Result<[City], Error>) -> Void) {
    
    let request = WeatherGroupRequest(cityIDs: cityIDs)
    
    apiHandler.create(request: request) { (result: Result<CityResponse, Error>) in
      switch result {
      case .failure(let error):
        completion(Result.failure(error))
      case .success(let response):
        completion(Result.success(response.list))
      }
    }
  }
}
