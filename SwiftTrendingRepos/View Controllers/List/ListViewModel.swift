//
//  ListViewModel.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import Foundation

class ListViewModel {
    
    private(set) var reposList: [GithubRepo] = []
    
    var apiServiceWorker: ApiServiceWorkerProtocol?
    var isDataExist: Bool {
        return !reposList.isEmpty
    }
    
    init(apiService: ApiServiceWorkerProtocol = ApiServiceWorker() ) {
        apiServiceWorker = apiService
    }
 
    func fetchData(completion: @escaping (NetworkError?) -> ()) {
        apiServiceWorker?.getRepos(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.reposList = data
                DispatchQueue.main.async { completion(nil) }
                
            case .failure(let error):
                DispatchQueue.main.async { completion(error) }
            }
        })
    }
}
