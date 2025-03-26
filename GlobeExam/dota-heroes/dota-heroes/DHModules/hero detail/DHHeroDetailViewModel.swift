//
//  DHHeroDetailViewModel.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import UIKit

struct DHHeroInfo {
    var title: String
    var detail: String
}

class DHHeroDetailViewModel: DHViewModel<DHHeroDetailView> {
    
    var heroInfo: [DHHeroInfo] = []
    
    override func setupLayout() {
        super.setupLayout()
        // Intentionally empty
    }
    override func setupRequests() {
        super.setupRequests()
        // Intentionally empty
    }
}

extension DHHeroDetailViewModel {
    
    func setup(with heroModel: DHHeroModel?) {
        guard let heroModel = heroModel else {
            return
        }
        self.view.vBanner.lbName.text = heroModel.localized_name
        
        self.setRoles(heroModel)
        self.setAttributes(heroModel)
        self.fetchHeroImage(heroModel)
        self.setupHeroDetails(heroModel)
    }
}

extension DHHeroDetailViewModel {
    
    private func setRoles(_ heroModel: DHHeroModel) {
        let mattributed = NSMutableAttributedString()
        mattributed.append(NSAttributedString(
            string: heroModel.attack_type.uppercased(),
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12),
                .foregroundColor: UIColor.white
            ]
        ))
        mattributed.append(NSAttributedString(
            string: " - ",
            attributes: [
                .foregroundColor: UIColor.white.withAlphaComponent(0.7)
            ]))
        mattributed.append(NSAttributedString(
            string: heroModel.roles.joined(separator: ", ").uppercased(),
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 12),
                .foregroundColor: UIColor.white.withAlphaComponent(0.7)
            ]
        ))
        self.view.vBanner.lbRoles.attributedText = mattributed
    }
    
    private func setAttributes(_ heroModel: DHHeroModel) {
        let mattributed = NSMutableAttributedString()
        mattributed.append(NSAttributedString(
            string: "•",
            attributes: [
                .font: UIFont.systemFont(ofSize: 40.0),
                .foregroundColor: DHHeroList.PRIMARY_ATTR.strength.color
            ]
        ))
        mattributed.append(NSAttributedString(
            string: "\(heroModel.base_str) + \(heroModel.str_gain)",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        ))
        mattributed.append(NSAttributedString(string: "    "))
        mattributed.append(NSAttributedString(
            string: "•",
            attributes: [
                .font: UIFont.systemFont(ofSize: 40.0),
                .foregroundColor: DHHeroList.PRIMARY_ATTR.agility.color
            ]
        ))
        mattributed.append(NSAttributedString(
            string: "\(heroModel.base_agi) + \(heroModel.agi_gain)",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        ))
        mattributed.append(NSAttributedString(string: "    "))
        mattributed.append(NSAttributedString(
            string: "•",
            attributes: [
                .font: UIFont.systemFont(ofSize: 40.0),
                .foregroundColor: DHHeroList.PRIMARY_ATTR.intellegence.color
            ]
        ))
        mattributed.append(NSAttributedString(
            string: "\(heroModel.base_int) + \(heroModel.int_gain)",
            attributes: [
                .foregroundColor: UIColor.white
            ]
        ))
        self.view.vBanner.lbAttrbutes.attributedText = mattributed
    }
    
    private func fetchHeroImage(_ heroModel: DHHeroModel) {
        DispatchQueue.global(qos: .background).async {
            DHShared.fetch.fetchHeroImage(with: heroModel.img) { result in
                switch result {
                case .success(let image):
                    self.view.vBanner.imMain.image = image
                case .failure:
                    self.view.vBanner.imMain.image = DHUI.Image.main
                }
            }
        }
    }
    
    private func setupHeroDetails(_ heroModel: DHHeroModel) {
        self.heroInfo = [
            DHHeroInfo(title: "BASE ATTACK:", detail: "\(heroModel.base_attack_min) - \(heroModel.base_attack_max)"),
            DHHeroInfo(title: "ATTACK RANGE:", detail: "\(heroModel.attack_range)"),
            DHHeroInfo(title: "ATTACK SPEED:", detail: "\(heroModel.base_attack_time)"),
            DHHeroInfo(title: "PROJECTILE SPEED:", detail: "\(heroModel.projectile_speed)"),
            DHHeroInfo(title: "HEALTH:", detail: "\(heroModel.base_health)"),
            DHHeroInfo(title: "HEALTH REGEN:", detail: "\(heroModel.base_health_regen ?? 0)"),
            DHHeroInfo(title: "MANA:", detail: "\(heroModel.base_mana)"),
            DHHeroInfo(title: "MANA REGEN:", detail: "\(heroModel.base_mana_regen)"),
            DHHeroInfo(title: "BASE ARMOR:", detail: "\(heroModel.base_armor)"),
            DHHeroInfo(title: "MAGIC_RESISTANCE:", detail: "\(heroModel.base_mr)"),
            DHHeroInfo(title: "MOVE SPEED:", detail: "\(heroModel.move_speed)"),
            DHHeroInfo(title: "TURN SPEED:", detail: "\(heroModel.turn_rate ?? 0)"),
            DHHeroInfo(title: "NUMBER OF LEGS:", detail: "\(heroModel.legs)"),
            DHHeroInfo(title: "CM ENABLED:", detail: "\(heroModel.cm_enabled)")
        ]
        self.view.tbMain.reloadData()
    }
}
