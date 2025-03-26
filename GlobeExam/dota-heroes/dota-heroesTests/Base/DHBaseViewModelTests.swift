//
//  BaseViewModelTests.swift
//
//  Created by Joey Joseph Villafuerte on 3/11/21.
//

import XCTest
@testable import dota_heroes

class DHBaseViewModelTests: XCTestCase {
    
    var responseError: Error?
    
    var fakeProviders: DHFakeProviders!
    
    var fakeServiceModel: DHServiceModel!
    
    override func setUp() {
        super.setUp()
        
        self.fakeProviders = DHFakeProviders()
        
        self.fakeServiceModel = DHServiceModel(
            heroService: DHHeroService(provider: self.fakeProviders.heroFakeProvider.getProvider())
        )
        
        self.beforeTests()
    }
}

extension DHBaseViewModelTests {
    
    @objc func beforeTests() {
         // Intentionally unimplemented
    }
    
    @objc func testSuccessful() {
        // Interntionally unimplemented
    }
    
    @objc func testFailedEmpty() {
        // Interntionally unimplemented
    }
    
    @objc func testFailedError() {
        // Interntionally unimplemented
    }
    
    @objc func testOtherFunctions() {
        // Interntionally unimplemented
    }
}
