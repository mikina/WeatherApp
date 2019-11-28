import Foundation

struct CityForecastCellViewModel {
  
  let temperature: String
  let date: String
  
  private static let CelsiusDegree = "℃"
  private static let FahrenheitDegree = "℉"
  
  static func createCityForecastCellViewModel(from forecasts: [Forecast]) -> [CityForecastCellViewModel] {
    
    let datePresenter: DatePresenterProtocol = resolve()
    
    return forecasts.map { (item) -> CityForecastCellViewModel in
      let temperatureRepresentation: String
      
      if let temp = item.main.temp {
        let roundedValues = Int(CityForecastCellViewModel.convertKelvinToCelsius(temperature: temp))
        temperatureRepresentation = "\(roundedValues) \(CityForecastCellViewModel.CelsiusDegree)"
      } else {
        temperatureRepresentation = "-"
      }
      
      return CityForecastCellViewModel(temperature: temperatureRepresentation, date: datePresenter.present(date: item.dt))
    }
  }
  
  // TODO: This should be refactored!
  private static func convertKelvinToCelsius(temperature: Double) -> Double {
    return temperature - 273.15
  }
}
