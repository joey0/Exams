//
//  DHService.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import Moya

typealias DHServiceResult<T: Decodable> = (Swift.Result<T, Error>) -> Void

class DHService<T: TargetType> {
    
    var service: APIService<T>
    
    required init(
        provider: MoyaProvider<T>? = nil,
        plugins: [PluginType] = []
    ) {
        self.service = APIService(provider: provider ?? MoyaProvider<T>(
            plugins: plugins
        ))
    }
}
