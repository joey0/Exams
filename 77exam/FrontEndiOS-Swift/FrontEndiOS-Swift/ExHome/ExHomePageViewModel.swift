//
//  ExHomePageViewModel.swift
//  FrontEndiOS-Swift
//
//  Created by Joey Villafuerte on 2/10/25.
//

import UIKit

class ExHomePageViewModel {
    
    var view: ExHomePageView
    
    var navigateTo: ((_ viewController: UIViewController?) -> Void)?
    
    init(view: UIView? = nil) {
        self.view = (view as? ExHomePageView) ?? ExHomePageView()
        self.view.btBackToLoginPressed = { _ in
            self.navigateTo?(nil)
        }
    }
}
