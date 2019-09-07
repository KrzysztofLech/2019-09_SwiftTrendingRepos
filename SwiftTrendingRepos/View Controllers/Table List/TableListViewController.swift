//
//  TableListViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol TableListViewControllerDelegate: AnyObject {
    func refreshData(completion: @escaping ()->())
}

final class TableListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var data: [GithubRepoViewModel] = []
    weak var delegate: TableListViewControllerDelegate?
    
    private let controller = TableListController()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(cellAndNibName: SimpleTableViewCell.toString())
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc private func refreshData() {
        delegate?.refreshData { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }
    }
}

extension TableListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.toString(), for: indexPath) as? SimpleTableViewCell else { return UITableViewCell() }
        let cellData = data[indexPath.row]
        cell.configure(withData: cellData)
        controller.getImage(url: cellData.avatarUrl) { image in
            cell.setupAvatarImage(image)
        }
        return cell
    }
}

extension TableListViewController: UITableViewDelegate {}
