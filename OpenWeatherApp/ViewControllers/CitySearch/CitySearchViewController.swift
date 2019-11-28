import UIKit

class CitySearchViewController: UIViewController {
  
  private let citySearchView = CitySearchView()
  lazy var citySearchViewModel = CitySearchViewModel()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    title = NSLocalizedString("Search for a City", comment: "")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = citySearchView
    citySearchViewModel.load(tableView: citySearchView.tableView, searchBar: citySearchView.searchBar)
  }
}
