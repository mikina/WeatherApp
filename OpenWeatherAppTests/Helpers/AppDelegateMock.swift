@testable import OpenWeatherApp
import UIKit

class AppDelegateMock: NSObject, UIApplicationDelegate {
  
  @objc var window: UIWindow?
  var container = DIContainer.container
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UIViewController()
    window?.makeKeyAndVisible()
    
    return true
  }
}
