//
//  ImageCacheService.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 08/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol ImageCacheServiceProtocol {
    func cache(object: UIImage, forKey key: String)
    func getFromCache(key: String) -> UIImage?
}

final class ImageCacheService: ImageCacheServiceProtocol {

    private var cache = NSCache<NSString, UIImage>()
    
    func cache(object: UIImage, forKey key: String) {
        guard getFromCache(key: key) == nil else {
            return
        }
        
        cache.setObject(object, forKey: key as NSString)
    }
    
    func getFromCache(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
