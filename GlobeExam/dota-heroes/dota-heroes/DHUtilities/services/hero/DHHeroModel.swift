//
//  DHHeroModel.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation

struct DHHeroModel: Codable {
    
    var id: Int
    var name: String
    var primary_attr: String
    var attack_type: String
    var roles: [String]
    var img: String
    var icon: String
    var localized_name: String
    
    var base_str: Double
    var str_gain: Double
    
    var base_agi: Double
    var agi_gain: Double
    
    var base_int: Double
    var int_gain: Double
    
    var base_attack_min: Double
    var base_attack_max: Double
    
    var attack_range: Double
    var base_attack_time: Double
    
    var projectile_speed: Double
    
    var base_health: Double
    var base_health_regen: Double? = 0
    
    var base_mana: Double
    var base_mana_regen: Double
    
    var base_armor: Double
    var base_mr: Double
    
    var move_speed: Double
    var turn_rate: Double? = 0
    
    var legs: Double
    var cm_enabled: Bool
}
