import Foundation


// TODO: Error support needs additional states. 
enum APIHandlerHTTP: Error {
  case incorrectURL
  case serverError
}
