//
//  ExLoginView.swift
//  FrontEndiOS-Swift
//
//  Created by Joey Villafuerte on 2/10/25.
//

import Foundation
import UIKit

class ExLoginView: UILabel {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txUsername: UITextField!
    @IBOutlet weak var txPassword: UITextField!
    
    @IBOutlet weak var lbStatus: UILabel!
    
    @IBOutlet weak var btLogin: UIButton!
    
    var loginButtonPressed: ((_ button: UIButton) -> Void)?
    var usernameDidChange: ((_ value: String) -> Void)?
    var passwordDidChange: ((_ value: String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @IBAction func btLoginAction(_ sender: Any) {
        self.loginButtonPressed?(sender as! UIButton)
    }
}

// TextField DidChange
//
extension ExLoginView {
    
    func setupView() {
        
        self.configurations()
        self.listeners()
    }
    
    private func configurations() {
        self.lbStatus.text = ""
        self.btLogin.isEnabled = false
    }
    
    private func listeners() {
        self.txUsername.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.txPassword.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case self.txUsername:
            self.usernameDidChange?(textField.text ?? "")
        case self.txPassword:
            self.passwordDidChange?(textField.text ?? "")
        default:
            break
        }
    }
    
}
