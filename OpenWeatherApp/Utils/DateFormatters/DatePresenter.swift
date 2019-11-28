import Foundation

protocol DatePresenterProtocol {
  func present(date: Date) -> String
}

struct UserLocaleDatePresenter: DatePresenterProtocol {
  var formatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    
    return formatter
  }()
  
  func present(date: Date) -> String {
    return formatter.string(from: date)
  }
}
