import UIKit

class CitySearchCell: UITableViewCell {
  
  static let cityFontSize: CGFloat = 25 // Size of city name
  static let temperatureFontSize: CGFloat = 25 // Size of temperature value
  static let paddingSize: CGFloat = 25 // Size of edges padding
  
  let cityNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: CitiesListCell.cityFontSize)
    label.textColor = .black
    return label
  }()
  
  let countryLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  let addIconLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: CitiesListCell.temperatureFontSize)
    label.textColor = .black
    label.textAlignment = .right
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    doLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func doLayout() {
    
    addSubview(cityNameLabel)
    addSubview(countryLabel)
    addSubview(addIconLabel)
    
    cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
    countryLabel.translatesAutoresizingMaskIntoConstraints = false
    addIconLabel.translatesAutoresizingMaskIntoConstraints = false
    addIconLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
    countryLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    cityNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    
    let constraints = [
      cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: CitiesListCell.paddingSize),
      cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CitiesListCell.paddingSize),
      countryLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
      countryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CitiesListCell.paddingSize),
      countryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CitiesListCell.paddingSize),
      
      cityNameLabel.heightAnchor.constraint(equalTo: countryLabel.heightAnchor),
      
      addIconLabel.topAnchor.constraint(equalTo: topAnchor, constant: CitiesListCell.paddingSize),
      addIconLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CitiesListCell.paddingSize),
      addIconLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CitiesListCell.paddingSize),
      
      addIconLabel.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: CitiesListCell.paddingSize),
      addIconLabel.leadingAnchor.constraint(equalTo: countryLabel.trailingAnchor, constant: CitiesListCell.paddingSize)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}
