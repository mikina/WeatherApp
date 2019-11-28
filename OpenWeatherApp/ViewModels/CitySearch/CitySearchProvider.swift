import Foundation

class CitySearchProvider: TableViewManagerProtocol {
  
  var manager: TableViewManager
  var rows = [TableViewCellItemProtocol]()
  var cities = [City]()
  
  init(manager: TableViewManager = TableViewManager()) {
    self.manager = manager
  }
  
  func load(with items: [City]) {
    cities = items
    let rows = prepareItems(with: items)
    manager.reload(with: rows)
  }

  private func prepareItems(with items: [City]) -> [TableViewCellItemProtocol] {
    let citiesItems: [CitySearchCellItem] = items.map({CitySearchCellItem(city: $0)})
    return citiesItems
  }
}
