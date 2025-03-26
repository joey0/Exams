//
//  DHHeroList.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import UIKit

struct DHHeroList: Codable {
    
    enum PRIMARY_ATTR: String, CaseIterable, Codable {
        case strength = "str"
        case agility = "agi"
        case intellegence = "int"
        case universal = "all"
        
        var color: UIColor {
            switch self {
            case .strength:
                return .systemRed
            case .agility:
                return .systemGreen
            case .intellegence:
                return .systemBlue
            case .universal:
                return .systemPurple
            }
        }
    }
    
    var all: [DHHeroModel]?
    
    func getList(with attribute: PRIMARY_ATTR) -> [DHHeroModel] {
        return self.all?.filter({
            $0.primary_attr == attribute.rawValue
        }) ?? []
    }
}
