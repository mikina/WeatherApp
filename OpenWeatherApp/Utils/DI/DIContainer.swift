import Foundation
import Dip

func resolve<T>() -> T {
  
  do {
    return try DIContainer.container.resolve()
  } catch {
    fatalError("Not registered DI: \(error)")
  }
}

class DIContainer {
  
  static var container = DependencyContainer { container in
    registerItems(on: container)
  }
}

fileprivate extension DIContainer {
  
  static func registerItems(on container: DependencyContainer) {
    container.register { CitiesListProvider() as CitiesListProvider }
    container.register { APIHandler() as APIHandlerProtocol }
    container.register { WeatherGroupService() as WeatherGroupServiceProtocol }
    container.register { CitySearchProvider() as CitySearchProvider }
    container.register { CitySearchService() as CitySearchServiceProtocol }
    container.register { CityForecastProvider() as CityForecastProvider }
    container.register { CityForecastService() as CityForecastServiceProtocol }
    container.register { UserLocaleDatePresenter() as DatePresenterProtocol }
  }
}
