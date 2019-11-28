import Foundation

class CityForecastProvider: TableViewManagerProtocol {
  
  var manager: TableViewManager
  var rows = [TableViewCellItemProtocol]()
  var items = [CityForecastCellViewModel]()
  
  init(manager: TableViewManager = TableViewManager()) {
    self.manager = manager
  }
  
  func load(with items: [CityForecastCellViewModel]) {
    self.items = items
    let rows = prepareItems(with: items)
    manager.reload(with: rows)
  }

  private func prepareItems(with items: [CityForecastCellViewModel]) -> [TableViewCellItemProtocol] {
    let citiesItems: [CityForecastCellItem] = items.map({CityForecastCellItem(cityForecastCellViewModel: $0)})
    return citiesItems
  }
}
