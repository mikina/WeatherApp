import UIKit

protocol TableViewManagerProtocol: class {

  var manager: TableViewManager { get }
  func set(tableView: UITableView)
}

extension TableViewManagerProtocol {

  func set(tableView: UITableView) {
    manager.tableView = tableView
  }
}
