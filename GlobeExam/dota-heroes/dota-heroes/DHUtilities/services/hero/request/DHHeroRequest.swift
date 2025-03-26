//
//  DHHeroRequest.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import Moya

enum DHHeroRequest: TargetType {
    case heroStats
}

extension DHHeroRequest {
    var baseURL: URL {
        return URL(string: "https://api.opendota.com/api")!
    }
    
    var path: String {
        return "heroStats"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String: String]? {
        var header: [String: String] = [:]
        header["Content-Type"] = "application/json"
        return header
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
