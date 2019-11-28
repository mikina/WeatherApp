import UIKit

class CitiesListViewController: UIViewController {
  
  private let citiesListView = CitiesListView()
  lazy var citiesListViewModel = CitiesListViewModel()
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    title = NSLocalizedString("Weather", comment: "")
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = citiesListView
    citiesListViewModel.load(tableView: citiesListView.tableView)
  }
}
