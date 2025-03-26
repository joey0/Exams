//
//  DHViewModel.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit

class DHViewModel<T: DHView>: DHVCProtocol {
    
    var rootUI: UIView
    
    var view: T
    
    var service: DHServiceModel
    
    required init(
        parentView: UIView = UIView(),
        service: DHServiceModel? = nil
    ) {
        self.view = T.init(parentView: parentView)
        self.rootUI = self.view
        
        self.service = service ?? DHServiceModel()
        
        self.setupLayout()
        self.setupRequests()
    }
    // Conform VCProtocol
    //
    func cancelAllServices() {
        self.service.cancelAllServices()
    }
    
    // Internal functions
    //
    open func setupLayout() {
        // Intentionally empty
    }
    open func setupRequests() {
        // Intentionally empty
    }
}
