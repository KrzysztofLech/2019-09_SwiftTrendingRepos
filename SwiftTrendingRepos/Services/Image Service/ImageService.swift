//
//  TableListController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol ImageServiceProtocol {
    func getImage(url: String, completion: @escaping (UIImage?) -> ())
    func downloadImage(url: String, completion: @escaping (UIImage?) -> ())
}

final class ImageService: ImageServiceProtocol {
    
    private var apiServiceWorker: ApiServiceWorkerProtocol
    private var imageCacheService: ImageCacheServiceProtocol
    
    init(apiServiceWorker: ApiServiceWorkerProtocol = ApiServiceWorker(), imageCacheService: ImageCacheServiceProtocol = ImageCacheService()) {
        self.apiServiceWorker = apiServiceWorker
        self.imageCacheService = imageCacheService
    }
    
    func getImage(url: String, completion: @escaping (UIImage?) -> ()) {
        guard let image = imageCacheService.getFromCache(key: url) else {
            downloadImage(url: url, completion: completion)
            return
        }
        
        completion(image)
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> ()) {
        apiServiceWorker.downloadImage(url: url, completion: { [weak self] image in
            guard let image = image else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            self?.imageCacheService.cache(object: image, forKey: url)
            DispatchQueue.main.async { completion(image) }
        })
    }
}
