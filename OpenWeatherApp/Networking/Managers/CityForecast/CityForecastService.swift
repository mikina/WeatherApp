import Foundation

protocol CityForecastServiceProtocol {
  func getForecastFor(cityID: Int, completion: @escaping (Result<[Forecast], Error>) -> Void)
}

class CityForecastService: CityForecastServiceProtocol {
  
  private let apiHandler: APIHandlerProtocol = resolve()
  
  func getForecastFor(cityID: Int, completion: @escaping (Result<[Forecast], Error>) -> Void) {
    
    let request = CityForecastRequest(cityID: cityID)
    
    apiHandler.create(request: request) { (result: Result<ForecastResponse, Error>) in
      switch result {
      case .failure(let error):
        completion(Result.failure(error))
      case .success(let response):
        completion(Result.success(response.list))
      }
    }
  }
}
