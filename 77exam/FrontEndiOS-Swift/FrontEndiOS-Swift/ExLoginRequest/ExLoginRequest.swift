//
//  ExLoginRequest.swift
//  FrontEndiOS-Swift
//
//  Created by Joey Villafuerte on 2/10/25.
//

import Foundation

enum ExLoginEnum: Int {
    case success = 0
    case failed = 1 // unknown username or password
    
    var error: String {
        switch self {
        case .success:
            return ""
        case .failed:
            return "Invalid username and/or password"
        }
    }
    
}
// Assumed response from server
//
struct ExLoginRequest {
    var status: ExLoginEnum
    var reason: String?
}
