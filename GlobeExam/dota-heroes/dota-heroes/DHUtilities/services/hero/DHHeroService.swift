//
//  DHHeroService.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import Moya

class DHHeroService: DHService<DHHeroRequest> {
    
    func heroList(completion: @escaping DHServiceResult<DHHeroList>) {
        self.service.request(
            required: .heroStats,
            type: [DHHeroModel].self
        ) { result in
            switch result {
            case .success(let response):
                completion(Swift.Result.success(DHHeroList(all: response)))
            case .failure(let error):
                completion(Swift.Result.failure(error))
            }
        }
    }
}
