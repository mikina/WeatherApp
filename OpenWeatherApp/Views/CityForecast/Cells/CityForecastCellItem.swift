import UIKit

class CityForecastCellItem: TableViewCellItem<CityForecastCell> {
  
  weak var cell: CityForecastCell?
  var cityForecastCellViewModel: CityForecastCellViewModel
  
  init(cityForecastCellViewModel: CityForecastCellViewModel) {
    self.cityForecastCellViewModel = cityForecastCellViewModel
    
    super.init()
  }
  
  override func setLayout(of cell: CityForecastCell) {
    cell.temperatureLabel.text = cityForecastCellViewModel.temperature
    cell.dateLabel.text = cityForecastCellViewModel.date
  }
}
