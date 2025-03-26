//
//  DHMainView.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit
import SnapKit

class DHMainView: DHView {
    
    var vTitle: UIView = {
        let vTitle = UIView()
        return vTitle
    }()
    
    var imTitle: UIImageView = {
        let imTitle = UIImageView(image: DHUI.Image.main)
        imTitle.frame.size.width = 50.0
        imTitle.frame.size.height = 50.0
        imTitle.contentMode = .scaleAspectFill
        return imTitle
    }()
    
    var lbTitle: UILabel = {
        let lbTitle = UILabel()
        lbTitle.text = "HEROES"
        lbTitle.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        return lbTitle
    }()
    
    var cvList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 75.0, height: 75.0)
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 15.0, bottom: 25.0, right: 15.0)
        let cvList = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cvList
    }()
    
    override func setupLayout() {
        super.setupLayout()
        
        self.cvList.register(
            DHMainCell.self,
            forCellWithReuseIdentifier: DHMainCell.identifier
        )
        self.cvList.register(
            DHMainSection.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DHMainSection.identifier
        )
    }

    override func setupSubviews() {
        super.setupSubviews()
        
        self.subviews(forAutoLayout: [
            self.cvList
        ])
    }

     override func setupConstraints() {
        super.setupConstraints()
         
         self.cvList.snp.makeConstraints { make in
             make.top.equalToSuperview()
             make.leading.equalToSuperview()
             make.trailing.equalToSuperview()
             make.bottom.equalToSuperview()
         }
    }
}
