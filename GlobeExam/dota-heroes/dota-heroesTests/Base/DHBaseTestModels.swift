//
//  BaseTestModels.swift
//
//  Created by Joey Joseph Villafuerte on 10/28/20.
//

import XCTest
@testable import dota_heroes

public struct TestModel {
    var index: Int
    var describe: String
}

public struct DHFakeProviders {
    
    var heroFakeProvider: FakeMoyaProvider<DHHeroRequest> = FakeMoyaProvider<DHHeroRequest>()
}

enum TestType: String {
    case success = "Successful"
    case customSuccess = "Custom Successful"
    case empty = "Failure: Empty"
    case customEmpty = "Custom Failure: Empty"
    case error = "Failure: Error"
    case customError = "Custom Failure: Error"
    case all
}
