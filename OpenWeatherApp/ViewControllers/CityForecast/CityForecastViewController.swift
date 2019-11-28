import UIKit

class CityForecastViewController: UIViewController {
  
  private let cityForecastView = CityForecastView()
  lazy var cityForecastViewModel = CityForecastViewModel()
  var city: City
  
  init(city: City) {
    self.city = city
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = cityForecastView
    cityForecastViewModel.load(tableView: cityForecastView.tableView, city: city)
  }
}
