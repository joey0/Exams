//
//  ExHomePageView.swift
//  FrontEndiOS-Swift
//
//  Created by Joey Villafuerte on 2/10/25.
//

import UIKit

class ExHomePageView: UILabel {
    
    @IBOutlet weak var btBackToLogin: UIButton!
    
    var btBackToLoginPressed: ((_ button: UIButton) -> Void)?
    
    @IBAction func btBackToLoginAction(_ sender: Any) {
        self.btBackToLoginPressed?(sender as! UIButton)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
