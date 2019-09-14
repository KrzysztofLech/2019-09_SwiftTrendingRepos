//
//  VariedListViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class VariedListViewController: UIViewController, Presentable {
    
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
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 10, right: 0)
        
        tableView.register(cellAndNibName: LargeTableViewCell.toString())
        tableView.register(cellAndNibName: RegularTableViewCell.toString())
        tableView.register(cellAndNibName: CompactTableViewCell.toString())
        
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
        let cell: (UITableViewCell & PresentableCell)?
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: LargeTableViewCell.toString(), for: indexPath) as? LargeTableViewCell
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: RegularTableViewCell.toString(), for: indexPath) as? RegularTableViewCell
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: CompactTableViewCell.toString(), for: indexPath) as? CompactTableViewCell
        }
        
        let cellData = data[indexPath.section][indexPath.row]
        cell?.configure(withData: cellData)
        imageService.getImage(url: cellData.avatarUrl) { image in
            cell?.setupAvatarImage(image)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed(HeaderView.toString(), owner: self, options: nil)?.last as? HeaderView
        headerView?.setTitleForSection(section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension VariedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectedRepo(atIndex: indexPath)
    }
}
