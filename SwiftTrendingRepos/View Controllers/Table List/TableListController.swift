//
//  TableListController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class TableListController {
    
    private var apiServiceWorker: ApiServiceWorkerProtocol
    
    init(apiServiceWorker: ApiServiceWorkerProtocol = ApiServiceWorker()) {
        self.apiServiceWorker = apiServiceWorker
    }
    
    func getImage(url: String, completion: @escaping (UIImage?) -> ()) {
        downloadImage(url: url, completion: completion)
    }
    
    private func downloadImage(url: String, completion: @escaping (UIImage?) -> ()) {
        apiServiceWorker.downloadImage(url: url, completion: { image in
            DispatchQueue.main.async { completion(image) }
        })
    }
}
