import UIKit

class CityForecastCoordinator: CoordinatorProtocol {
  
  var childCoordinators = [CoordinatorProtocol]()
  var navigationController: UINavigationController
  var city: City
  private var cityForecastViewController: CityForecastViewController?
  
  init(navigationController: UINavigationController, city: City) {
    self.navigationController = navigationController
    self.city = city
  }
  
  func start() {
    cityForecastViewController = CityForecastViewController(city: city)
    cityForecastViewController?.cityForecastViewModel.coordinator = self
    navigationController.pushViewController(cityForecastViewController!, animated: true)
  }
}

extension CityForecastCoordinator: CityForecastCoordinatorAction {
  func set(title: String) {
    cityForecastViewController?.title = title
  }
}
