import UIKit

/// Simple UITableView wrapper.
class TableViewManager: NSObject {
  
  weak var delegate: TableViewManagerDelegate?
  var rows: [TableViewCellItemProtocol] = []
  
  weak var tableView: UITableView? {
    didSet {
      setupTableView()
    }
  }
  
  func reload(with items: [TableViewCellItemProtocol]) {
    items.forEach {
        register(item: $0)
    }
    
    rows = items
    tableView?.reloadData()
  }
  
  private func register(item: TableViewCellItemProtocol) {
    
    guard let tableView = tableView else {
      fatalError("There is no tableview!")
    }
    
    tableView.register(NSClassFromString(item.registerID), forCellReuseIdentifier: item.registerID)
  }
  
  private func setupTableView() {
    if let table = tableView {
      table.delegate = self
      table.dataSource = self
      table.reloadData()
    }
  }
}

extension TableViewManager: UITableViewDataSource {
    
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rows.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = rows[indexPath.row]
    let tableViewCell = tableView.dequeueReusableCell(withIdentifier: item.registerID, for: indexPath)

    item.delegate = self
    item.present(tableViewCell)
    
    return tableViewCell
  }
}

extension TableViewManager: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return rows[indexPath.row].height
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return rows[indexPath.row].height
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = rows[indexPath.row]
    delegate?.tableViewManager(self, didSelect: item)
    tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension TableViewManager: TableViewCellItemDelegate {
  func tableViewCellItemHasBeenSelected(_ item: TableViewCellItemProtocol) {
    delegate?.tableViewManager(self, didSelect: item)
  }
}

protocol TableViewManagerDelegate: class {
  func tableViewManager(_ manager: TableViewManager, didSelect item: TableViewCellItemProtocol)
}
