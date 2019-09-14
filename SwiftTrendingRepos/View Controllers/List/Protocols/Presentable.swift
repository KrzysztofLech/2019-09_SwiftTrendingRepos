//
//  Presentable.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol Presentable {
    var tableView: UITableView! { get set }
    var data: [GithubRepoViewModel] { get set }
    var delegate: TableListViewControllerDelegate? { get set }
}
