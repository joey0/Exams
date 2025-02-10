//
//  ExLoginViewModel.swift
//  FrontEndiOS-Swift
//
//  Created by Joey Villafuerte on 2/10/25.
//

import Foundation
import UIKit

class ExLoginViewModel {
    
    var view: ExLoginView
    
    var retryCounter: Int = 0
    
    var username: String? = ""
    var password: String? = ""
    
    var navigateTo: ((_ viewController: UIViewController?) -> Void)?
    
    init(view: UIView? = nil) {
        self.view = (view as? ExLoginView) ?? ExLoginView()
        
        self.view.setupView()
        
        self.view.usernameDidChange = { username in
            self.view.lbStatus.text = ""
            self.username = username
            self.loginInputValidation()
        }
        self.view.passwordDidChange = { password in
            self.view.lbStatus.text = ""
            self.password = password
            self.loginInputValidation()
        }
        
        self.view.loginButtonPressed = { _ in
            self.loginEvaluation()
        }
    }
}

// Login evaluation
//
extension ExLoginViewModel {
    
    private func loginInputValidation() {
        let minimumInputLength: Int = 4
        let validUsername = (self.username?.count ?? 0) >= minimumInputLength
        let validPassword = (self.password?.count ?? 0) >= minimumInputLength
        self.view.btLogin.isEnabled = validUsername && validPassword
    }
    
    private func loginRefresh() {
        self.retryCounter = 0
        self.username = ""
        self.password = ""
        self.view.lbStatus.text = ""
        self.view.txUsername.text = ""
        self.view.txPassword.text = ""
    }
    
    private func loginEvaluation() {
        
        var loginRequest: ExLoginRequest = ExLoginModel(
            username: self.username ?? "",
            password: self.password ?? ""
        ).evaluate()
        
        if self.retryCounter >= 5 {
            loginRequest = ExLoginRequest(
                status: .failed,
                reason: "Exceeded maximum retry count. Please try again later."
            )
        }
        
        switch loginRequest.status {
        case .success:
            print("Login successful: Welcome!")
            self.loginRefresh()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homePageVC = storyboard.instantiateViewController(withIdentifier: "ExHomePageVC")
            self.navigateTo?(homePageVC)
        case .failed where loginRequest.reason != nil:
            self.view.lbStatus.text = loginRequest.reason
        case .failed:
            self.retryCounter+=1;
            self.view.lbStatus.text = loginRequest.status.error
        }
    }
}
