import UIKit

class CitySearchCoordinator: CoordinatorProtocol {
  
  var childCoordinators = [CoordinatorProtocol]()
  var navigationController: UINavigationController
  weak var delegate: CitiesListCoordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let citySearchViewController = CitySearchViewController()
    citySearchViewController.citySearchViewModel.coordinator = self
    navigationController.pushViewController(citySearchViewController, animated: true)
  }
}

extension CitySearchCoordinator: CitySearchCoordinatorAction {
  func selected(city: City) {
    delegate?.addNewCity(city: city)
    navigationController.popViewController(animated: true)
  }
}
