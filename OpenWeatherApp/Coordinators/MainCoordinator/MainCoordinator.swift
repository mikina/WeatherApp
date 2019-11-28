import UIKit

class MainCoordinator: CoordinatorProtocol {
  
  weak var window: UIWindow?
  var navigationController: UINavigationController
  var childCoordinators = [CoordinatorProtocol]()
  
  init(window: UIWindow?, navigationController: UINavigationController = UINavigationController()) {
    self.window = window
    self.navigationController = navigationController
  }
  
  func start() {
    let citiesListCoordinator = CitiesListCoordinator(navigationController: navigationController)
    childCoordinators.append(citiesListCoordinator)
    citiesListCoordinator.start()
    
    window?.rootViewController = navigationController
  }
}
