//
//  ListViewModel.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import Foundation

class ListViewModel {
    
    private(set) var reposList: [GithubRepoViewModel] = []
    
    var apiServiceWorker: ApiServiceWorkerProtocol?
    var repoCounter: Int { return reposList.count }
    
    init(apiService: ApiServiceWorkerProtocol = ApiServiceWorker() ) {
        apiServiceWorker = apiService
    }
 
    func fetchData(completion: @escaping (NetworkError?) -> ()) {
        apiServiceWorker?.getRepos(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.reposList = data
                    .sorted { $0.stars > $1.stars }
                    .map { GithubRepoViewModel(from: $0) }
                DispatchQueue.main.async { completion(nil) }
                
            case .failure(let error):
                DispatchQueue.main.async { completion(error) }
            }
        })
    }
}
