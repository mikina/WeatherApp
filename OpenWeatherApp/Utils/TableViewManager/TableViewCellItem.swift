import UIKit

protocol TableViewCellItemProtocol: class {
  var registerID: String { get }
  var height: CGFloat { get }
  var delegate: TableViewCellItemDelegate? { get set }
  func present(_ cell: UITableViewCell)
}

protocol TableViewCellItemDelegate: class {
  func tableViewCellItemHasBeenSelected(_ item: TableViewCellItemProtocol)
}

class TableViewCellItem<T: UITableViewCell>: TableViewCellItemProtocol {
  
  var registerID: String = String(reflecting: T.self)
  var height: CGFloat = UITableView.automaticDimension
  weak var delegate: TableViewCellItemDelegate?
  
  func present(_ cell: UITableViewCell) {
    if let cell = cell as? T {
      setLayout(of: cell)
    }
  }
  
  func setLayout(of cell: T) {}
  init() {}
}
