import UIKit

let kAppDelegateClass: AnyClass = NSClassFromString("OpenWeatherAppTests.AppDelegateMock") ?? AppDelegate.self

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(kAppDelegateClass))
