//
//  ListViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    private var viewModel: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ListViewModel()
        fetchData()
    }

    private func fetchData() {
        viewModel?.fetchData(completion: { [weak self] error in
            if let error = error {
                self?.showAlert(withTitle: error.message)
            } else {
                print(self?.viewModel?.reposList.count)
            }
        })
    }
    
    private func showAlert(withTitle title: String) {
        let alertController = Alert.tryAgain(withTitle: title) { [weak self] in
            self?.fetchData()
        }
        present(alertController, animated: true)
    }
}
