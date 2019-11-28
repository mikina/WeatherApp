import UIKit

class CitySearchCellItem: TableViewCellItem<CitySearchCell> {
  
  weak var cell: CitiesListCell?
  var city: City
  
  init(city: City) {
    self.city = city
    
    super.init()
  }
  
  override func setLayout(of cell: CitySearchCell) {
    cell.cityNameLabel.text = city.name
    let country = city.sys?.country ?? "-"
    cell.countryLabel.text = "\(NSLocalizedString("Country", comment: "")): \(country)"
    cell.addIconLabel.text = "➕"
  }
}
