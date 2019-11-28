import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var coordinator: MainCoordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    coordinator = MainCoordinator(window: window)
    coordinator?.start()
    window?.makeKeyAndVisible()
    
    return true
  }
}
