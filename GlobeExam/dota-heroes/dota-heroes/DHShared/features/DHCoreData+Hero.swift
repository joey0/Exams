//
//  DHCoreData+Hero.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/26/25.
//

import Foundation
import CoreData

extension DHCoreData {
    
    struct GetResult<T: Codable> {
        var count: Int = 0
        var model: T?
    }
    
    func saveHeroList(with model: DHHeroList) {
        
        let context = self.container.viewContext
        
        guard let entity = DHCoreData.Entity.HeroList(managedContext: context).entityDescription else {
            print("DHCoreData[Save HeroList]: Entity Description failed")
            return
        }
        
        do {
            
            let encoded = try JSONEncoder().encode(model)
            print("encoded: \(encoded)")
            let heroModel = NSManagedObject(entity: entity, insertInto: context)
            heroModel.setValue("hero_list", forKey: "id")
            heroModel.setValue(encoded, forKey: "data")
            
            self.save(managedContext: context)
            
        } catch let error {
            print("DHCoreData[Save HeroList]: Encoding failed with error -> \(error.localizedDescription)")
        }
    }
    
    private func getRequest() -> NSFetchRequest<NSFetchRequestResult> {
        
        let entityName: String = DHCoreData.Entity.HeroList().entityName
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "id == 'hero_list'")
        return request
    }
    
    func getSavedHeroList() -> GetResult<DHHeroList>? {
        
        let context = self.container.viewContext
        let request = self.getRequest()
        
        do {
            
            guard
                let results = try context.fetch(request) as? [NSManagedObject],
                let result = results.first,
                let data = result.value(forKey: "data") as? Data,
                let model = try? JSONDecoder().decode(DHHeroList.self, from: data) else {
                return nil
            }
            
            return GetResult<DHHeroList>(
                count: try context.count(for: request),
                model: model
            )
            
        } catch let error {
            print("DHCoreData[Get HeroList]: Get failed with error -> \(error.localizedDescription)")
        }
        
        return GetResult<DHHeroList>()
    }
}
