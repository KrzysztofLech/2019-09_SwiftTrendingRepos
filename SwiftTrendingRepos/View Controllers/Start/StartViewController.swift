//
//  StartViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 05/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {
    
    var apiServiceWorker: ApiServiceWorkerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiServiceWorker = ApiServiceWorker()
        fetchData()
    }
    
    private func fetchData() {
        apiServiceWorker?.getRepos(completion: { result in
            switch result {
            case .success(let data):
                print(data.count)
                data.forEach { print($0.name) }
                
            case .failure(let error):
                print(error)
            }
        })
    }
}
