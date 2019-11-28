import Foundation

protocol APIHandlerProtocol {
  func create<T: Codable>(request: APIHandlerRequestProtocol, result: @escaping (Result<T, Error>) -> Void)
}

class APIHandler: APIHandlerProtocol {
  
  var task: URLSessionDataTask?
  static let requestTimeout: TimeInterval = 60
  private let resultQueue: DispatchQueue
  
  init(resultQueue: DispatchQueue = .main) {
    self.resultQueue = resultQueue
  }
  
  func create<T: Codable>(request: APIHandlerRequestProtocol, result: @escaping (Result<T, Error>) -> Void) {
    perform(request: request) { [weak self] (completion: Result<T, Error>) in
      guard let strongSelf = self else {
        return
      }
      
      strongSelf.resultQueue.async {
        result(completion)
      }
    }
  }
  
  private func perform<T: Codable>(request: APIHandlerRequestProtocol, result: @escaping (Result<T, Error>) -> Void) {
    guard let endpoint = getURL(from: request) else {
      result(Result.failure(APIHandlerHTTP.incorrectURL))
      return
    }
    
    var urlRequest = URLRequest(url: endpoint, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: APIHandler.requestTimeout)
    urlRequest.httpMethod = request.method.rawValue
    
    task = URLSession.shared.dataTask(with: urlRequest, completionHandler: { [weak self] (data, _, error) in
      guard let strongSelf = self else {
        return
      }
      
      if let error = error {
        result(Result.failure(error))
        return
      }
      
      strongSelf.parseResponse(data: data, result: result)
    })
    
    task?.resume()
  }
  
  private func parseResponse<T: Codable>(data: Data?, result: @escaping (Result<T, Error>) -> Void) {
    guard let dataToParse = data else {
      result(Result.failure(APIHandlerHTTP.serverError))
      return
    }
    
    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    jsonDecoder.dateDecodingStrategy = .secondsSince1970
    
    do {
      let parsed = try jsonDecoder.decode(T.self, from: dataToParse)
      result(Result.success(parsed))
    } catch {
      result(Result.failure(error))
    }
  }
  
  private func getURL(from request: APIHandlerRequestProtocol) -> URL? {
    
    guard let base = URL(string: request.endpoint) else {
      return nil
    }
    
    var urlComponents = URLComponents(url: base, resolvingAgainstBaseURL: false)
    
    if let queryParameters = request.query {
      let queryItems = queryParameters.map { (parameter) -> URLQueryItem in
        URLQueryItem(name: parameter.key, value: parameter.value)
      }

      urlComponents?.queryItems = queryItems
    }

    return urlComponents?.url
  }
}
