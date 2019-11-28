import UIKit

class CitySearchViewModel: NSObject, UISearchBarDelegate {
  private var cities: [City] = []

  let provider: CitySearchProvider = resolve()
  var searchBar: UISearchBar?
  weak var coordinator: CitySearchCoordinatorAction?
  private var debounceRequestWorkItem: DispatchWorkItem?
  private static let debounceTimeout = 750
  
  private let citySearchService: CitySearchServiceProtocol = resolve()

  func load(tableView: UITableView, searchBar: UISearchBar) {
    provider.set(tableView: tableView)
    provider.manager.delegate = self
    
    setup(searchBar: searchBar)
  }
  
  func searchFor(cityName: String) {
    guard !cityName.isEmpty else {
      return
    }
    
    citySearchService.searchFor(cityName: cityName) { [weak self] result in
      guard let strongSelf = self else {
        return
      }
    
      switch result {
      case .success(let cities):
        strongSelf.cities = cities
        strongSelf.reloadTableView()
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func select(city: City) {
    coordinator?.selected(city: city)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let cityName = searchBar.text {
      searchFor(cityName: cityName)
    }
    searchBar.resignFirstResponder()
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text?.removeAll()
    searchBar.resignFirstResponder()
    cities = []
    reloadTableView()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    debounceRequestWorkItem?.cancel()
    
    let requestWorkItem = DispatchWorkItem { [weak self] in
      self?.searchFor(cityName: searchText)
    }
    
    debounceRequestWorkItem = requestWorkItem
    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(CitySearchViewModel.debounceTimeout), execute: requestWorkItem)
  }
  
  private func reloadTableView() {
    provider.load(with: cities)
  }
  
  private func setup(searchBar: UISearchBar) {
    self.searchBar = searchBar
    self.searchBar?.delegate = self
    self.searchBar?.showsCancelButton = true
  }
}

extension CitySearchViewModel: TableViewManagerDelegate {
  
  func tableViewManager(_ manager: TableViewManager, didSelect item: TableViewCellItemProtocol) {
    
    guard let cell = item as? CitySearchCellItem else { return }
    select(city: cell.city)
  }
}
