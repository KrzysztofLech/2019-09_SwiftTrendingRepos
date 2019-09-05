//
//  ApiServiceWorker.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 05/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol ApiServiceWorkerProtocol: AnyObject {
    func getRepos(completion: @escaping (Result<[GithubRepo], NetworkError>) -> Void)
    func downloadImage(url: String, completion: @escaping (Result<UIImage, NetworkError>)->())
}

final class ApiServiceWorker: ApiServiceWorkerProtocol {
    
    private let provider: ProviderProtocol
    
    init(provider: ProviderProtocol = URLSessionProvider()) {
        self.provider = provider
    }
    
    func getRepos(completion: @escaping (Result<[GithubRepo], NetworkError>) -> Void) {
        let service = ApiService.getRepos
        provider.request(type: [GithubRepo].self, service: service, completion: completion)
    }
    
    func downloadImage(url: String, completion: @escaping (Result<UIImage, NetworkError>)->()) {
        provider.downloadImage(url: url, completion: completion)
    }
}
