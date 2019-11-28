import Foundation
import Quick
import Nimble
import Dip

@testable import OpenWeatherApp

class CitySearchViewModelSpec: QuickSpec {
  override func spec() {
    describe("CitySearchViewModel") {
      
      var apiHandler: APIHandlerMock<CityResponse>!
      
      beforeEach {
        apiHandler = APIHandlerMock<CityResponse>()
        apiHandler.shouldReturnError = false
        
        DIContainer.container.register { apiHandler as APIHandlerProtocol }
        DIContainer.container.register { CitySearchProvider() as CitySearchProvider }
        DIContainer.container.register { CitySearchService() as CitySearchServiceProtocol }
      }
      
      context("initial state") {
        
        var sut: CitySearchViewModel!
        var tableview: UITableView!
        
        beforeEach {
          sut = CitySearchViewModel()
          tableview = UITableView()
          sut.load(tableView: tableview, searchBar: UISearchBar())
        }
        
        it("should not have any cities") {
          expect(sut.provider.cities.count).to(equal(0))
        }
      }
      
      context("search for a city") {
        
        var sut: CitySearchViewModel!
        var tableview: UITableView!
        
        beforeEach {
          sut = CitySearchViewModel()
          tableview = UITableView()
          sut.load(tableView: tableview, searchBar: UISearchBar())
          
          apiHandler.response = CityResponse(list: [
            City(id: 1, name: "Aarhus", main: CityTemp(temp: 279.99), sys: CityCountry(country: "DK"), weather: [CityWeather(description: "light rain", icon: "10n")])
          ])
          
          sut.searchFor(cityName: "Aarhus")
        }
        
        it("search for a city Aarhus") {
          expect(sut.provider.cities.count).to(equal(1))
          
          let item = sut.provider.cities[0]
          expect(item.name).to(equal("Aarhus"))
        }
      }
      
      context("action") {
        var sut: CitySearchViewModel!
        var tableview: UITableView!
        var coordinator: CitySearchCoordinatorMock!
        
        beforeEach {
          coordinator = CitySearchCoordinatorMock()
          sut = CitySearchViewModel()
          tableview = UITableView()
          sut.coordinator = coordinator
          sut.load(tableView: tableview, searchBar: UISearchBar())
        }
        
        it("select city") {
          let selected = City(id: 1, name: "Oslo", main: nil, sys: nil, weather: nil)
          sut.select(city: selected)
          
          expect(coordinator.selectedCityInvoked).to(beTrue())
          expect(coordinator.selectedCity?.name).to(equal("Oslo"))
        }
      }
    }
  }
}

class CitySearchCoordinatorMock: CitySearchCoordinatorAction {
  
  var selectedCityInvoked = false
  var selectedCity: City?
  
  func selected(city: City) {
    selectedCityInvoked = true
    selectedCity = city
  }
}
