//
//  DHImageFetcher.swift
//  dota-heroes
//
//  Created by Joey Villafuerte on 3/25/25.
//

import Foundation
import UIKit

class DHImageFetcher {
    
    static var imageCache: NSCache = NSCache<NSString, UIImage>()
    
    public func fetchHeroImage(with stringUrl: String, completion: @escaping ((Swift.Result<UIImage?, Error>) -> Void)) {
        
        let url = URL(string: "https://cdn.cloudflare.steamstatic.com"+stringUrl)
        let key = NSString(string: url!.absoluteString)
        
        if let image = DHImageFetcher.imageCache.object(forKey: key) {
            DispatchQueue.main.async {
                completion(.success(image))
            }
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                let image = UIImage(data: data) ?? UIImage()
                DHImageFetcher.imageCache.setObject(image, forKey: key)
                completion(.success(image))
            }
        }.resume()
    }
}
