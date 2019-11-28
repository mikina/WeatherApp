import Foundation
import Quick

@testable import OpenWeatherApp

class OpenWeatherAppQuickConfiguration: QuickConfiguration {
  override class func configure(_ configuration: Configuration) {
    configuration.beforeEach {
      DIContainer.container.reset()
    }
  }
}
