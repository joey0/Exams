//
//  DHHeroDetailView.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit
import SnapKit

class DHHeroDetailView: DHView {
    
    var vBanner: DHHeroDetailBannerView = {
        let vBanner = DHHeroDetailBannerView()
        return vBanner
    }()
    
    var tbMain: UITableView = {
        let tbMain = UITableView()
        return tbMain
    }()
    
    override func setupLayout() {
        super.setupLayout()
    }

    override func setupSubviews() {
        super.setupSubviews()
        
        self.subviews(forAutoLayout: [
            self.tbMain
        ])
    }

     override func setupConstraints() {
        super.setupConstraints()
         
         self.tbMain.snp.makeConstraints { make in
             make.top.equalToSuperview()
             make.leading.equalToSuperview()
             make.trailing.equalToSuperview()
             make.bottom.equalToSuperview()
         }
    }
    
    func setBanner() {
        self.tbMain.tableHeaderView = UIView()
        self.tbMain.tableHeaderView?.subviews(forAutoLayout: self.vBanner)
        self.vBanner.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10.0)
            make.trailing.equalToSuperview().inset(10.0)
            make.height.greaterThanOrEqualTo(0.0)
        }
        self.layoutIfNeeded()
        self.vBanner.layoutIfNeeded()
        self.tbMain.tableHeaderView?.frame.size.height = self.vBanner.frame.height
        self.tbMain.reloadData()
    }
}
