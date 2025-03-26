//
//  DHCoreData+Entity.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/26/25.
//

import Foundation
import CoreData

extension DHCoreData {
    
    enum Entity {
        case HeroList(managedContext: NSManagedObjectContext? = nil)
    }
}

extension DHCoreData.Entity {
    
    var entityName: String {
        switch self {
        case .HeroList:
            return "DHHeroListEntity"
        }
    }
    
    var entityDescription: NSEntityDescription? {
        switch self {
        case .HeroList(let managedContext):
            guard let context = managedContext else {
                return nil
            }
            return NSEntityDescription.entity(forEntityName: self.entityName, in: context)
        }
    }
}
