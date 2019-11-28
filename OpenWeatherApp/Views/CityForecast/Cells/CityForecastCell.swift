import UIKit

class CityForecastCell: UITableViewCell {
  
  static let temperatureFontSize: CGFloat = 25 // Size of temperature font
  static let dateFontSize: CGFloat = 18 // Size of date font
  static let paddingSize: CGFloat = 25 // Size of edges padding
  
  let temperatureLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: CityForecastCell.temperatureFontSize)
    label.textColor = .black
    return label
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: CityForecastCell.dateFontSize)
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
    
    addSubview(temperatureLabel)
    addSubview(dateLabel)
    
    temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.translatesAutoresizingMaskIntoConstraints = false
    dateLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: .horizontal)
    temperatureLabel.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
    
    let constraints = [
      temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: CitiesListCell.paddingSize),
      temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CitiesListCell.paddingSize),
      temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CitiesListCell.paddingSize),
      
      dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: CitiesListCell.paddingSize),
      dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CitiesListCell.paddingSize),
      dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -CitiesListCell.paddingSize),
      
      dateLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: CitiesListCell.paddingSize)
    ]
    
    NSLayoutConstraint.activate(constraints)
  }
}
