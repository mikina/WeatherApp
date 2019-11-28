import Foundation
@testable import OpenWeatherApp

internal class APIHandlerMock<T: Codable>: APIHandlerProtocol {

  var response: T?
  var shouldReturnError = false

  func create<T: Codable>(request: APIHandlerRequestProtocol, result: @escaping (Result<T, Error>) -> Void) {
    if shouldReturnError {
      result(Result.failure(APIHandlerHTTP.serverError))
    }
    else {
      result(Result.success(response as! T))
    }
  }
}
