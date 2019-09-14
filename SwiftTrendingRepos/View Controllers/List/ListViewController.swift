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
    
    private let viewModel: ListViewModel
    private var isVariedControlerVisible = false
    private var currentViewController: UIViewController?
    
    init(viewModel: ListViewModel = ListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolBarView.delegate = self
        fetchData()
    }

    private func fetchData() {
        activityIndicator.startAnimating()
        viewModel.fetchData(completion: { [weak self] error in
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
        toolBarView.changeCounterValue(viewModel.repoCounter)
        setupCurrentTableViewController()
    }
    
    private func setupCurrentTableViewController() {
        var listViewController: (Presentable & UIViewController) = isVariedControlerVisible ? VariedListViewController() : TableListViewController()
        addChild(listViewController)
        
        guard let listView = listViewController.view else { return }
        containerView.addSubview(listView)
        listView.fill(view: containerView)
        
        listViewController.delegate = self
        listViewController.data = viewModel.reposList
        
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()
        currentViewController = listViewController
    }
}

extension ListViewController: ToolBarViewDelegate {
    func changeLayoutButtonTapped() {
        isVariedControlerVisible.toggle()
        setupCurrentTableViewController()
    }
}

extension ListViewController: TableListViewControllerDelegate {
    func refreshData(completion: @escaping () -> ()) {
        viewModel.fetchData(completion: { [weak self] error in
            if let error = error {
                self?.showAlert(withTitle: error.message)
            } else {
                completion()
                self?.toolBarView.changeCounterValue(self?.viewModel.repoCounter ?? 0)
            }
        })
    }
    
    func selectedRepo(atIndex index: IndexPath) {
        let detailsViewController = DetailsViewController()
        detailsViewController.modalTransitionStyle = .crossDissolve
        detailsViewController.repoItem = viewModel.reposList[index.row]
        present(detailsViewController, animated: true)
    }
}
