import UIKit

class CitiesListCoordinator: CoordinatorProtocol {
  
  var childCoordinators = [CoordinatorProtocol]()
  var navigationController: UINavigationController
  let citiesListViewController = CitiesListViewController()
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    citiesListViewController.navigationItem.rightBarButtonItem =
      UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    citiesListViewController.citiesListViewModel.coordinator = self
    navigationController.pushViewController(citiesListViewController, animated: true)
  }
  
  @objc func addButtonTapped() {
    citiesListViewController.citiesListViewModel.openSearchCityScreen()
  }
}

extension CitiesListCoordinator: CitiesListCoordinatorAction {
  
  func searchForCity() {
    let citySearchCoordinator = CitySearchCoordinator(navigationController: navigationController)
    citySearchCoordinator.delegate = self
    childCoordinators.append(citySearchCoordinator)
    citySearchCoordinator.start()
  }
  
  func addNewCity(city: City) {
    citiesListViewController.citiesListViewModel.addNew(city: city)
  }
  
  func showForecastFor(city: City) {
    let forecastCoordinator = CityForecastCoordinator(navigationController: navigationController, city: city)
    childCoordinators.append(forecastCoordinator)
    forecastCoordinator.start()
  }
}
