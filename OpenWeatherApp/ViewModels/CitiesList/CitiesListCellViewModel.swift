import Foundation

struct CitiesListCellViewModel {
  
  let cityID: Int
  let cityName: String
  let description: String
  let temperature: String
  
  private static let CelsiusDegree = "℃"
  private static let FahrenheitDegree = "℉"
  
  static func createCityListViewModel(from cities: [City]) -> [CitiesListCellViewModel] {
    
    return cities.map { (item) -> CitiesListCellViewModel in
      let temperatureRepresentation: String
      
      if let temp = item.main?.temp {
        let roundedValues = Int(CitiesListCellViewModel.convertKelvinToCelsius(temperature: temp))
        temperatureRepresentation = "\(roundedValues) \(CitiesListCellViewModel.CelsiusDegree)"
      } else {
        temperatureRepresentation = "-"
      }
      
      let description = item.weather?.first?.description ?? "-"
      return CitiesListCellViewModel(cityID: item.id, cityName: item.name, description: description, temperature: temperatureRepresentation)
    }
    .sorted(by: { $0.cityName < $1.cityName })
  }
  
  // TODO: This should be refactored!
  private static func convertKelvinToCelsius(temperature: Double) -> Double {
    return temperature - 273.15
  }
}
