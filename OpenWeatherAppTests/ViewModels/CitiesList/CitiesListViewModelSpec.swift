import Foundation
import Quick
import Nimble
import Dip

@testable import OpenWeatherApp

class CitiesListViewModelSpec: QuickSpec {
  override func spec() {
    describe("CitiesListViewModel") {
      
      var apiHandler: APIHandlerMock<CityResponse>!
      
      beforeEach {
        apiHandler = APIHandlerMock<CityResponse>()
        apiHandler.shouldReturnError = false
        
        DIContainer.container.register { apiHandler as APIHandlerProtocol }
        DIContainer.container.register { CitiesListProvider() as CitiesListProvider }
        DIContainer.container.register { WeatherGroupService() as WeatherGroupServiceProtocol }
      }
      
      context("add new city") {
        
        var sut: CitiesListViewModel!
        var tableview: UITableView!
        
        beforeEach {
          sut = CitiesListViewModel()
          tableview = UITableView()
          sut.load(tableView: tableview)
          
          let newCity = City(id: 1, name: "Oslo", main: nil, sys: nil, weather: nil)
          apiHandler.response = CityResponse(list: [City(id: 1, name: "Oslo", main: CityTemp(temp: 274.11), sys: CityCountry(country: "NO"), weather: [CityWeather(description: "broken clouds", icon: "04n")])])
          
          sut.addNew(city: newCity)
        }
        
        it("provider should have new city on the list") {
          expect(sut.provider.rows.count).to(equal(1))
          
          let item = sut.provider.items[0]
          expect(item.cityName).to(equal("Oslo"))
          expect(item.description).to(equal("broken clouds"))
          expect(item.temperature).to(equal("0 ℃"))
        }
      }
      
      context("show list with cities") {
        
        var sut: CitiesListViewModel!
        var tableview: UITableView!
        
        beforeEach {
          sut = CitiesListViewModel()
          let cities = [City(id: 1, name: "Oslo", main: nil, sys: nil, weather: nil),
                        City(id: 2, name: "Aarhus", main: nil, sys: nil, weather: nil),
                        City(id: 3, name: "Lodz", main: nil, sys: nil, weather: nil)]
          
          sut.cities = cities
          
          apiHandler.response = CityResponse(list: [
            City(id: 1, name: "Oslo", main: CityTemp(temp: 274.11), sys: CityCountry(country: "NO"), weather: [CityWeather(description: "light snow", icon: "13n")]),
            City(id: 2, name: "Aarhus", main: CityTemp(temp: 279.99), sys: CityCountry(country: "DK"), weather: [CityWeather(description: "light rain", icon: "10n")]),
            City(id: 2, name: "Lodz", main: CityTemp(temp: 278.87), sys: CityCountry(country: "PL"), weather: [CityWeather(description: "mist", icon: "50n")])
          ])
          
          tableview = UITableView()
          sut.load(tableView: tableview)
        }
        
        it("provider should show 3 cities") {
          expect(sut.provider.rows.count).to(equal(3))
        }
        
        it("provider should show cities in right order - sorted by name") {
          expect(sut.provider.items[0].cityName).to(equal("Aarhus"))
          expect(sut.provider.items[1].cityName).to(equal("Lodz"))
          expect(sut.provider.items[2].cityName).to(equal("Oslo"))
        }
        
        it("city number 1: Aarhus") {
          let item = sut.provider.items[0]
          expect(item.cityName).to(equal("Aarhus"))
          expect(item.description).to(equal("light rain"))
          expect(item.temperature).to(equal("6 ℃"))
        }
        
        it("city number 2: Lodz") {
          let item = sut.provider.items[1]
          expect(item.cityName).to(equal("Lodz"))
          expect(item.description).to(equal("mist"))
          expect(item.temperature).to(equal("5 ℃"))
        }
        
        it("city number 3: Oslo") {
          let item = sut.provider.items[2]
          expect(item.cityName).to(equal("Oslo"))
          expect(item.description).to(equal("light snow"))
          expect(item.temperature).to(equal("0 ℃"))
        }
      }
      
      context("action") {
        var sut: CitiesListViewModel!
        var tableview: UITableView!
        var coordinator: CitiesListCoordinatorMock!
        
        beforeEach {
          coordinator = CitiesListCoordinatorMock()
          sut = CitiesListViewModel()
          tableview = UITableView()
          sut.coordinator = coordinator
          sut.load(tableView: tableview)
        }
        
        it("open search for a new city screen") {
          sut.openSearchCityScreen()
          expect(coordinator.searchForCityInvoked).to(beTrue())
        }
        
        it("show forecast for selected city") {
          let selected = City(id: 1, name: "Oslo", main: nil, sys: nil, weather: nil)
          sut.showForecastFor(city: selected)
          
          expect(coordinator.showForecastForInvoked).to(beTrue())
          expect(coordinator.showForecastForCity?.name).to(equal("Oslo"))
        }
      }
    }
  }
}

class CitiesListCoordinatorMock: CitiesListCoordinatorAction {
  
  var searchForCityInvoked = false
  var showForecastForInvoked = false
  
  var showForecastForCity: City?
  
  func searchForCity() {
    searchForCityInvoked = true
  }
  
  func addNewCity(city: City) {
    // Do nothing, add new city has been already tested.
  }
  
  func showForecastFor(city: City) {
    showForecastForInvoked = true
    showForecastForCity = city
  }
}
