import UIKit

protocol CoordinatorProtocol: AnyObject {
  func start()
  var childCoordinators: [CoordinatorProtocol] { get set }
  var navigationController: UINavigationController { get set }
}
