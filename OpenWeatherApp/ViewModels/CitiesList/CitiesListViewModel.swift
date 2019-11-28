import UIKit

class CitiesListViewModel {
  
  let provider: CitiesListProvider = resolve()
  weak var coordinator: CitiesListCoordinatorAction?
  
  private let weatherGroupService: WeatherGroupServiceProtocol = resolve()
  internal var cities: [City] = []
  
  func load(tableView: UITableView) {
    provider.set(tableView: tableView)
    provider.manager.delegate = self
    getWeather(for: cities)
  }
  
  func getWeather(for cities: [City]) {
    guard !cities.isEmpty else {
      return
    }
    
    let cityIDs = cities.map {$0.id}
    weatherGroupService.getWeatherGroup(cityIDs: cityIDs) { [weak self] result in
      guard let strongSelf = self else {
        return
      }
    
      switch result {
      case .success(let cities):
        strongSelf.cities = cities
        strongSelf.reloadTableView()
      case .failure(let error):
        // TODO: Add error support
        print(error)
      }
    }
  }
  
  func openSearchCityScreen() {
    coordinator?.searchForCity()
  }
  
  func showForecastFor(city: City) {
    coordinator?.showForecastFor(city: city)
  }
  
  func addNew(city: City) {
    let alreadyAdded = cities.filter { $0.id == city.id }
    guard alreadyAdded.isEmpty else {
      return
    }
    
    cities.append(city)    
    getWeather(for: cities)
  }
  
  private func reloadTableView() {
    let cityListViewModel = CitiesListCellViewModel.createCityListViewModel(from: cities)
    provider.load(with: cityListViewModel)
  }
}

extension CitiesListViewModel: TableViewManagerDelegate {
  
  func tableViewManager(_ manager: TableViewManager, didSelect item: TableViewCellItemProtocol) {
    
    guard let item = item as? CitiesListCellItem else { return }
    let filterCities = cities.filter { $0.id == item.cityListViewModel.cityID }.first
    guard let city = filterCities else { return }
    
    showForecastFor(city: city)
  }
}
