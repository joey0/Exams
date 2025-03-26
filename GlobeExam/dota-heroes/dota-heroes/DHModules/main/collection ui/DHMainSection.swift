//
//  DHMainSection.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit
import SnapKit

class DHMainSection: UICollectionReusableView {
    
    static let identifier: String = "DHMainSection"
    
    var lbTitle: UILabel = {
        let lbTitle = UILabel()
        lbTitle.textAlignment = .left
        lbTitle.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        return lbTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.subviews(forAutoLayout: [
            self.lbTitle
        ])
        
        self.lbTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().inset(15.0)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
