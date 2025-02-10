//
//  ExHomePageVC.swift
//  FrontEndiOS-Swift
//
//  Created by Joey Villafuerte on 2/10/25.
//

import UIKit

class ExHomePageVC: UIViewController {
    
    var viewModel: ExHomePageViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ExHomePageViewModel(view: self.view)
        self.viewModel.navigateTo = { viewController in
            guard viewController == nil else {
                return
            }
            self.dismiss(animated: true)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
