//
//  DHRoute.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import UIKit

public protocol DHRouteProtocol {
    func viewController() -> UIViewController?
}

enum DHRoute: DHRouteProtocol {
    
    case heroDetail(heroModel: DHHeroModel)
    
    func viewController() -> UIViewController? {
        switch self {
        case .heroDetail(let heroModel):
            let heroDetailVC = DHHeroDetailVC()
            heroDetailVC.heroModel = heroModel
            return heroDetailVC
        }
    }
}
