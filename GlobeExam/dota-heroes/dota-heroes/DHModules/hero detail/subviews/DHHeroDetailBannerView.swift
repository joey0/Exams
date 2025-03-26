//
//  DHHeroDetailBannerView.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/26/25.
//

import UIKit
import SnapKit

class DHHeroDetailBannerView: DHView {
    
    private var imBackground: UIImageView = {
        let imBackground = UIImageView()
        imBackground.layer.cornerRadius = 15.0
        imBackground.clipsToBounds = true
        imBackground.contentMode = .scaleAspectFill
        imBackground.image = DHUI.Image.wallpaper
        return imBackground
    }()
    
    private var brBackground: UIVisualEffectView = {
        let brBackground = UIVisualEffectView()
        brBackground.effect = UIBlurEffect(style: .regular)
        return brBackground
    }()
    
    var imMain: UIImageView = {
        let imMain = UIImageView()
        imMain.backgroundColor = .lightGray
        imMain.layer.cornerRadius = 15.0
        imMain.clipsToBounds = true
        imMain.contentMode = .scaleAspectFill
        return imMain
    }()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5.0
        return stackView
    }()
    
    var lbName: UILabel = {
        let lbName = UILabel()
        lbName.font = .boldSystemFont(ofSize: 32)
        lbName.textAlignment = .center
        lbName.textColor = .white
        lbName.numberOfLines = 0
        return lbName
    }()
    
    var lbRoles: UILabel = {
        let lbRoles = UILabel()
        lbRoles.textAlignment = .center
        lbRoles.numberOfLines = 0
        return lbRoles
    }()
    
    var lbAttrbutes: UILabel = {
        let lbAttrbutes = UILabel()
        lbAttrbutes.textAlignment = .center
        lbAttrbutes.textColor = .white
        lbAttrbutes.numberOfLines = 0
        lbAttrbutes.font = .boldSystemFont(ofSize: 16)
        return lbAttrbutes
    }()
    
    private let vStatContainer: UIView = UIView()
    
    private let vSpacer: UIView = UIView()
    
    override func setupLayout() {
        super.setupLayout()
        self.layer.cornerRadius = 15.0
        self.clipsToBounds = true
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        self.subviews(forAutoLayout: [
            self.imBackground,
            self.brBackground,
            self.imMain,
            self.stackView
        ])
        
        self.stackView.addArrangedSubview(self.lbName.contained)
        self.stackView.addArrangedSubview(self.lbRoles.contained)
        self.stackView.addArrangedSubview(self.lbAttrbutes.contained)
        self.stackView.addArrangedSubview(UIView())
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.imBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(15.0)
        }
        self.brBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(15.0)
        }
        self.imMain.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(180.0)
            make.height.equalTo(120.0)
        }
        self.stackView.snp.makeConstraints { make in
            make.top.equalTo(self.imMain.snp.bottom).offset(5.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().inset(15.0)
            make.height.greaterThanOrEqualTo(0.0)
            make.bottom.equalToSuperview().inset(15.0)
        }
        
        self.lbName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(0.0)
            make.bottom.equalToSuperview()
        }
        
        self.lbRoles.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(0.0)
            make.bottom.equalToSuperview()
        }
        self.lbAttrbutes.superview?.layer.cornerRadius = 15.0
        self.lbAttrbutes.superview?.backgroundColor = .black.withAlphaComponent(0.5)
        self.lbAttrbutes.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.0)
            make.leading.equalToSuperview().offset(15.0)
            make.trailing.equalToSuperview().inset(15.0)
            make.height.greaterThanOrEqualTo(0.0)
            make.bottom.equalToSuperview().inset(25.0)
        }
    }
}
