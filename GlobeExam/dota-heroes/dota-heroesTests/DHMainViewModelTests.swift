//
//  DHMainViewModelTests.swift
//  dota-heroesTests
//
//  Created by Joey Villafuerte on 3/25/25.
//

import XCTest
@testable import dota_heroes

class DHMainViewModelTests: DHBaseViewModelTests {
    
    var dhMainViewModel: DHMainViewModel!
    var fakeHeroList: [DHHeroModel]?
    var fakeResponse: DHHeroList?
    var fakeError: Error?
    
    override func beforeTests() {
        super.beforeTests()
        
        self.dhMainViewModel = DHMainViewModel(
            service: self.fakeServiceModel
        )
    }
    
    override func testSuccessful() {
        super.testSuccessful()
        
        XCTAssertNotNil(UnitTestMock.heroList.domainModel as? DHHeroList)
        
        let promise = expectation(description: "Has Response")
        self.fakeProviders.heroFakeProvider.mockData = UnitTestMock.heroList.response
        self.dhMainViewModel.service.heroService = DHHeroService(provider: self.fakeProviders.heroFakeProvider.getProvider())
        self.dhMainViewModel.service.heroService.heroList { result in
            if case .success(let response) = result {
                self.fakeResponse = response
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5.0)
        XCTAssertNotNil(self.fakeResponse)
    }
    
    override func testFailedError() {
        let promise = expectation(description: "Has Error Response")
        self.dhMainViewModel.service.heroService = DHHeroService(provider: self.fakeProviders.heroFakeProvider.getProvider(response: 500, statusError: true))
        self.dhMainViewModel.service.heroService.heroList { result in
            if case .failure(let error) = result {
                self.fakeError = error
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5.0)
        XCTAssertNotNil(self.fakeError)
    }
    
    override func testOtherFunctions() {
        super.testOtherFunctions()
        
        let decoder = JSONDecoder()
        do {
            let jsonData = UnitTestMock.heroList.response
            let heroList = try decoder.decode([DHHeroModel].self, from: jsonData)
            self.fakeHeroList = heroList
        } catch {
            print(error.localizedDescription)
        }
        
        XCTAssertNotNil(self.fakeHeroList)
    }
}
