//
//  ListViewModel.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import Foundation

class ListViewModel {
    
    private enum Constants {
        static let firstSectionItemQuantity = 3
        static let secondSectionItemQuantity = 10
    }
    
    private var reposList: [GithubRepoViewModel] = []
    var repoCounter: Int { return reposList.count }
    
    var oneSectionData: [[GithubRepoViewModel]] {
        var array: [[GithubRepoViewModel]] = []
        array.append(reposList)
        return array
    }
    
    var manySectionsData: [[GithubRepoViewModel]] {
        var array: [[GithubRepoViewModel]] = []
        
        let firstSectionData = Array(reposList.prefix(Constants.firstSectionItemQuantity))
        array.append(firstSectionData)
        
        let secondSectionData = Array(reposList.prefix(Constants.secondSectionItemQuantity))
        array.append(secondSectionData)

        let thirdSectionItemQuantity = reposList.count - Constants.secondSectionItemQuantity
        let thirdSectionData = Array(reposList.suffix(thirdSectionItemQuantity))
        array.append(thirdSectionData)
        
        return array
    }
    
    var apiServiceWorker: ApiServiceWorkerProtocol?
    
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
