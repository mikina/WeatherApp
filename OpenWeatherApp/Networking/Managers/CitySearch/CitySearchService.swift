import Foundation

protocol CitySearchServiceProtocol {
  func searchFor(cityName: String, completion: @escaping (Result<[City], Error>) -> Void)
}

class CitySearchService: CitySearchServiceProtocol {
  
  private let apiHandler: APIHandlerProtocol = resolve()
  
  func searchFor(cityName: String, completion: @escaping (Result<[City], Error>) -> Void) {
    
    let request = CitySearchRequest(name: cityName)
    
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
