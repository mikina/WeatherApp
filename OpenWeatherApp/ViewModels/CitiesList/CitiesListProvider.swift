import Foundation

class CitiesListProvider: TableViewManagerProtocol {
  
  var manager: TableViewManager
  var rows = [TableViewCellItemProtocol]()
  var items = [CitiesListCellViewModel]()
  
  init(manager: TableViewManager = TableViewManager()) {
    self.manager = manager
  }
  
  func load(with items: [CitiesListCellViewModel]) {
    self.items = items
    rows = prepareItems(with: items)
    manager.reload(with: rows)
  }

  private func prepareItems(with items: [CitiesListCellViewModel]) -> [TableViewCellItemProtocol] {
    let citiesItems: [CitiesListCellItem] = items.map({CitiesListCellItem(cityListViewModel: $0)})
    return citiesItems
  }
}
