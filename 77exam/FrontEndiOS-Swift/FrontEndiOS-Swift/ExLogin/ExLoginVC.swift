//
//  ExLoginVC.swift
//  FrontEndiOS-Swift
//
//  Created by Joey Villafuerte on 2/10/25.
//

import UIKit

class ExLoginVC: UIViewController {
    
    var viewModel: ExLoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ExLoginViewModel(view: self.view)
        self.viewModel.navigateTo = { viewController in
            guard let viewController = viewController else {
                return
            }
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
