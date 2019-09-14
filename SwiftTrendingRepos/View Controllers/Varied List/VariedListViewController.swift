//
//  VariedListViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

class VariedListViewController: UIViewController, Presentable {
    
    @IBOutlet var tableView: UITableView!
    
    var data: [[GithubRepoViewModel]] = []
    weak var delegate: TableListViewControllerDelegate?
    
    private let imageService: ImageServiceProtocol
    private let refreshControl = UIRefreshControl()
    
    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
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

extension VariedListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableViewCell.toString(), for: indexPath) as? SimpleTableViewCell else { return UITableViewCell() }
        let cellData = data[indexPath.section][indexPath.row]
        cell.configure(withData: cellData)
        imageService.getImage(url: cellData.avatarUrl) { image in
            cell.setupAvatarImage(image)
        }
        return cell
    }
}

extension VariedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedRepo(atIndex: indexPath)
    }
}
