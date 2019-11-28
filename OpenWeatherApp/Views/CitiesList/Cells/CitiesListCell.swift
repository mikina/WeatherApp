import UIKit

class CitiesListCell: UITableViewCell {
  
  static let cityFontSize: CGFloat = 25 // Size of city name
  static let temperatureFontSize: CGFloat = 25 // Size of temperature value
  static let paddingSize: CGFloat = 25 // Size of edges padding
  
  let cityNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: CitiesListCell.cityFontSize)
    label.textColor = .black
    return label
  }()
  
  let weatherDescription: UILabel = {
    let label = UILabel()
    label.textColor = .black
    return label
  }()
  
  let temperatureLabel: UILabel = {
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
    addSubview(weatherDescription)
    addSubview(temperatureLabel)
    
    cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
    weatherDescription.translatesAutoresizingMaskIntoConstraints = false
    temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    temperatureLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
    weatherDescription.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    cityNameLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    
    let constraints = [
      cityNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: CitiesListCell.paddingSize),
      cityNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CitiesListCell.paddingSize),
      weatherDescription.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
      weatherDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CitiesListCell.paddingSize),
      weatherDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CitiesListCell.paddingSize),
      
      cityNameLabel.heightAnchor.constraint(equalTo: weatherDescription.heightAnchor),
      
      temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: CitiesListCell.paddingSize),
      temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CitiesListCell.paddingSize),
      temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CitiesListCell.paddingSize),
      
      temperatureLabel.leadingAnchor.constraint(equalTo: cityNameLabel.trailingAnchor, constant: CitiesListCell.paddingSize),
      temperatureLabel.leadingAnchor.constraint(equalTo: weatherDescription.trailingAnchor, constant: CitiesListCell.paddingSize)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}
