import Foundation

protocol CitiesListCoordinatorAction: class {
  func searchForCity()
  func addNewCity(city: City)
  func showForecastFor(city: City)
}
