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
        if section == 0 { return 1 }
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: LargeTableViewCell.toString(), for: indexPath) as? LargeTableViewCell
            cell?.configure(withData: data[indexPath.section], delegate: delegate)
            return cell ?? UITableViewCell()
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RegularTableViewCell.toString(), for: indexPath) as? RegularTableViewCell
            let cellData = data[indexPath.section][indexPath.row]
            cell?.configure(withData: cellData)
            imageService.getImage(url: cellData.avatarUrl) { image in
                cell?.setupAvatarImage(image)
            }
            return cell ?? UITableViewCell()
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CompactTableViewCell.toString(), for: indexPath) as? CompactTableViewCell
            let dataIndex = data[1].count + indexPath.row + 1
            let cellData = data[indexPath.section][indexPath.row]
            cell?.configure(withData: cellData, index: dataIndex)
            return cell ?? UITableViewCell()
        }
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
        guard indexPath.section != 0 else { return }
        delegate?.selectedRepo(atIndex: indexPath)
    }
}
