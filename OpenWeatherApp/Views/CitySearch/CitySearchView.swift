import UIKit

class CitySearchView: UIView {
  
  let tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .plain)
    
    return tableView
  }()
  
  let searchBar: UISearchBar = {
    let searchBar = UISearchBar(frame: .zero)
    
    return searchBar
  }()
  
  init() {
    super.init(frame: .zero)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupLayout() {
    
    addSubview(searchBar)
    addSubview(tableView)
    
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false

    let constraints = [
      searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
      searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
      
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ]

    NSLayoutConstraint.activate(constraints)
    
    self.backgroundColor = .white
  }
}
