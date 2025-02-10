//
//  ExLoginModel.swift
//  FrontEndiOS-Swift
//
//  Created by Joey Villafuerte on 2/10/25.
//

import Foundation

// Assumed payload to server
//
struct ExLoginModel {
    // For demo credentials
    //
    var expectedUsername: String = "joey"
    var expectedPassword: String = "77Exam1234!"
    
    var username: String
    var password: String
    
    func evaluate() -> ExLoginRequest {
        let unmatchedUsername = self.expectedUsername != self.username
        let unmatchedPassword = self.expectedPassword != self.password
        let unmatched = unmatchedUsername || unmatchedPassword
        return ExLoginRequest(
            status: unmatched ? .failed : .success
        )
    }
}
