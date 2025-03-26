//
//  UnitTestMock.swift
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
@testable import dota_heroes

public enum UnitTestMock {
    case heroList
}

extension UnitTestMock {
    
    public var domainModel: Any {
        switch self {
        case .heroList:
            return DHHeroList(all: [
                DHHeroModel(
                    id: 1,
                    name: "testing-ito",
                    primary_attr: "agi",
                    attack_type: "melee",
                    roles: ["support"],
                    img: "https://",
                    icon: "https://",
                    localized_name: "Testing Ito",
                    base_str: 1.0,
                    str_gain: 1.0,
                    base_agi: 1.0,
                    agi_gain: 1,
                    base_int: 0,
                    int_gain: 1.0,
                    base_attack_min: 1.0,
                    base_attack_max: 1.0,
                    attack_range: 1.0,
                    base_attack_time: 1.0,
                    projectile_speed: 1.0,
                    base_health: 1.0,
                    base_health_regen: 1.0,
                    base_mana: 1.0,
                    base_mana_regen: 1.0,
                    base_armor: 1.0,
                    base_mr: 1.0,
                    move_speed: 1.0,
                    turn_rate: 2, 
                    legs: 2,
                    cm_enabled: true
                )
            ])
        }
    }
}

extension UnitTestMock {
    
    public var response: Data {
        return self.dataFrom(resource: "GetHeroList")
    }
}

// Make sure the file's Main Project target member is ticked
//
extension UnitTestMock {
    
    static func model<T: Decodable>(_ type: T.Type, data: UnitTestMock) -> T? {
        do {
            let json = try JSONDecoder().decode(T.self, from: data.response)
            return json
        } catch {
            return nil
        }
    }
    
    func dataFrom(resource: String) -> Data {
        guard
           let url = Bundle.main.url(forResource: resource, withExtension: "json"),
           let data = try? Data(contentsOf: url)
        else { return Data() }
        
        return data
    }
}
