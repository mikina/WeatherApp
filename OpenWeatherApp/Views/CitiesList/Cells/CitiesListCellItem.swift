import UIKit

class CitiesListCellItem: TableViewCellItem<CitiesListCell> {
  
  weak var cell: CitiesListCell?
  var cityListViewModel: CitiesListCellViewModel
  
  init(cityListViewModel: CitiesListCellViewModel) {
    self.cityListViewModel = cityListViewModel
    
    super.init()
  }
  
  override func setLayout(of cell: CitiesListCell) {
    cell.cityNameLabel.text = cityListViewModel.cityName
    cell.weatherDescription.text = cityListViewModel.description
    cell.temperatureLabel.text = cityListViewModel.temperature
  }
}
