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
    
    init(apiServiceWorker: ApiServiceWorkerProtocol = ApiServiceWorker()) {
        self.apiServiceWorker = apiServiceWorker
    }
    
    func getImage(url: String, completion: @escaping (UIImage?) -> ()) {
        guard let image = ImageCacheService.shared.getFromCache(key: url) else {
            downloadImage(url: url, completion: completion)
            return
        }
        
        completion(image)
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> ()) {
        apiServiceWorker.downloadImage(url: url, completion: { image in
            guard let image = image else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            ImageCacheService.shared.cache(object: image, forKey: url)
            DispatchQueue.main.async { completion(image) }
        })
    }
}
