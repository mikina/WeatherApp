import Foundation

protocol APIHandlerRequestProtocol {
  var endpoint: String { get }
  var method: HTTPMethod { get }
  var query: [String: String]? { get }
}
