//
//  ListViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var toolBarView: ToolBarView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ListViewModel()
        fetchData()
    }

    private func fetchData() {
        activityIndicator.startAnimating()
        viewModel?.fetchData(completion: { [weak self] error in
            self?.activityIndicator.stopAnimating()
            if let error = error {
                self?.showAlert(withTitle: error.message)
            } else {
                self?.presentData()
            }
        })
    }
    
    private func showAlert(withTitle title: String) {
        let alertController = Alert.tryAgain(withTitle: title) { [weak self] in
            self?.fetchData()
        }
        present(alertController, animated: true)
    }
    
    private func presentData() {
        toolBarView.changeCounterValue(viewModel?.repoCounter ?? 0)
        showTable()
    }
    
    private func showTable() {
        let tableListViewController = TableListViewController()
        addChild(tableListViewController)
        
        let tableListView = tableListViewController.view ?? UIView()
        containerView.addSubview(tableListView)
        tableListView.fill(view: containerView)
        
        tableListViewController.delegate = self
        tableListViewController.data = viewModel?.reposList ?? []
    }
}

extension ListViewController: TableListViewControllerDelegate {
    func refreshData(completion: @escaping () -> ()) {
        viewModel?.fetchData(completion: { [weak self] error in
            if let error = error {
                self?.showAlert(withTitle: error.message)
            } else {
                completion()
                self?.toolBarView.changeCounterValue(self?.viewModel?.repoCounter ?? 0)
            }
        })
    }
    
    func selectedRepo(atIndex index: IndexPath) {
        let detailsViewController = DetailsViewController(nibName: DetailsViewController.toString(), bundle: nil)
        detailsViewController.modalTransitionStyle = .crossDissolve
        detailsViewController.repoItem = viewModel?.reposList[index.row]
        present(detailsViewController, animated: true)
    }
}
