//
//  DHView.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import UIKit

class DHView: UIView {
    
    public required init(parentView: UIView = UIView()) {
        super.init(frame: parentView.frame)
        self.backgroundColor = .white
        self.setupLayout()
        self.setupSubviews()
        self.setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Internal functions
//
extension DHView {
    
    @objc open func setupLayout() {
        // Intentionally empty
    }
    @objc open func setupSubviews() {
        // Intentionally empty
    }
    @objc open func setupConstraints() {
        // Intentionally unimplemented
    }
}
