import UIKit

class CityForecastViewModel: NSObject {

  var coordinator: CityForecastCoordinatorAction?
  let provider: CityForecastProvider = resolve()
  
  private var city: City?
  private let cityForecastService: CityForecastServiceProtocol = resolve()
  private var forecast: [Forecast] = []
  
  func load(tableView: UITableView, city: City) {
    provider.set(tableView: tableView)
    provider.manager.delegate = self
    self.city = city
    
    coordinator?.set(title: NSLocalizedString("Weather forecast: \(city.name)", comment: ""))
    getForecast(for: city.id)
  }
  
  private func getForecast(for cityID: Int) {

    cityForecastService.getForecastFor(cityID: cityID) { [weak self] result in
      guard let strongSelf = self else {
        return
      }
      
      switch result {
      case .success(let result):
        strongSelf.forecast = result
        strongSelf.reloadTableView()
      case .failure(let error):
        // TODO: Add error support
        print(error)
      }
    }
  }
  
  private func reloadTableView() {
    let cityForecastCellViewModel = CityForecastCellViewModel.createCityForecastCellViewModel(from: forecast)
    provider.load(with: cityForecastCellViewModel)
  }
}

extension CityForecastViewModel: TableViewManagerDelegate {
  func tableViewManager(_ manager: TableViewManager, didSelect item: TableViewCellItemProtocol) {
  }
}
