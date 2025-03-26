//
//  DHVCWithViewModelAndModel.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation

class DHVCWithViewModelAndModel<T: DHVCProtocol, U: DHModel>: DHVCWithViewModel<T> {
    
    public var model: U?
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setup(model: self.model)
    }
    
    open func setup(model: U?) {
        guard let model = model else {
            return
        }
        self.model = model
        self.didSetup(model: model)
    }
    
    open func didSetup(model: U) {
        // Intentionally unimplemented
    }
}
