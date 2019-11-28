import Foundation
import Quick
import Nimble
import Dip

@testable import OpenWeatherApp

class CityForecastViewModelSpec: QuickSpec {
  override func spec() {
    describe("CityForecastViewModel") {
      
      var apiHandler: APIHandlerMock<ForecastResponse>!
      
      beforeEach {
        apiHandler = APIHandlerMock<ForecastResponse>()
        apiHandler.shouldReturnError = false
        
        DIContainer.container.register { apiHandler as APIHandlerProtocol }
        DIContainer.container.register { CityForecastProvider() as CityForecastProvider }
        DIContainer.container.register { CityForecastService() as CityForecastServiceProtocol }
        DIContainer.container.register { UserLocaleDatePresenterMock() as DatePresenterProtocol }
      }
      
      context("load forecast for city") {
        var sut: CityForecastViewModel!
        var tableview: UITableView!
        var coordinator: CityForecastCoordinatorMock!
        
        beforeEach {
          
          apiHandler.response = ForecastResponse(list: [
            Forecast(main: ForecastTemp(temp: 280.42), weather: [ForecastWeather(description: "light rain", icon: "10n")], dt: Date(timeIntervalSince1970: 1574953200)),
            Forecast(main: ForecastTemp(temp: 280.28), weather: [ForecastWeather(description: "light rain", icon: "10n")], dt: Date(timeIntervalSince1970: 1574964000)),
            Forecast(main: ForecastTemp(temp: 278.39), weather: [ForecastWeather(description: "light rain", icon: "10n")], dt: Date(timeIntervalSince1970: 1574974800)),
          ])
          
          let city = City(id: 1, name: "Aarhus", main: nil, sys: nil, weather: nil)
          coordinator = CityForecastCoordinatorMock()
          
          sut = CityForecastViewModel()
          sut.coordinator = coordinator
          tableview = UITableView()
          sut.load(tableView: tableview, city: city)
        }
        
        it("should set title for VC") {
          expect(coordinator.titleValue).to(equal("Weather forecast: Aarhus"))
        }
        
        it("provider should show 3 weather items") {
          expect(sut.provider.items.count).to(equal(3))
        }
        
        it("weather items should be displayed correctly") {
          expect(sut.provider.items[0].temperature).to(equal("7 ℃"))
          expect(sut.provider.items[0].date).to(equal("11/28/19, 3:00 PM"))
          expect(sut.provider.items[1].temperature).to(equal("7 ℃"))
          expect(sut.provider.items[1].date).to(equal("11/28/19, 6:00 PM"))
          expect(sut.provider.items[2].temperature).to(equal("5 ℃"))
          expect(sut.provider.items[2].date).to(equal("11/28/19, 9:00 PM"))
        }
      }
    }
  }
}

class UserLocaleDatePresenterMock: DatePresenterProtocol {
  var formatter: DateFormatter = {
    var formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    formatter.locale = Locale(identifier: "en_US")
    formatter.timeZone = TimeZone(identifier: "UTC")
    
    return formatter
  }()
  
  func present(date: Date) -> String {
    return formatter.string(from: date)
  }
}

class CityForecastCoordinatorMock: CityForecastCoordinatorAction {
  
  var titleValue = ""
  
  func set(title: String) {
    titleValue = title
  }
}
