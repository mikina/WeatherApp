import UIKit

class CityForecastView: UIView {
  
  let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    tableView.tableFooterView = UIView()
    tableView.allowsSelection = false
    
    return tableView
  }()
  
  init() {
    super.init(frame: .zero)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    addSubview(tableView)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
      tableView.topAnchor.constraint(equalTo: topAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ]

    NSLayoutConstraint.activate(constraints)
    
    self.backgroundColor = .white
  }
}
