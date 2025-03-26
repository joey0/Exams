//
//  DHVCWithViewModel.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import UIKit

class DHVCWithViewModel<T: DHVCProtocol>: UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
    }
    
    // MARK: - ViewModel Setup
    //
    open func setupViewModel(_ viewModel: T? = nil) {
        guard viewModel != nil else {
            return
        }
        self.viewModel = viewModel
    }
    
    @objc open func didSetViewModel() {
        // Intentionally unimplemented
    }
    
    public var viewModel: T! {
        didSet {
            self.view = self.viewModel.rootUI
            self.didSetViewModel()
        }
    }
}
