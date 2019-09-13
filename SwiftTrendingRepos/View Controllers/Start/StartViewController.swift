//
//  StartViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 05/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigateToListScreen()
    }
    
    private func navigateToListScreen() {
        let listViewController = ListViewController()
        listViewController.modalTransitionStyle = .crossDissolve
        present(listViewController, animated: true)
    }
}
