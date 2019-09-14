//
//  TableListViewControllerDelegate.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol TableListViewControllerDelegate: AnyObject {
    func refreshData(completion: @escaping ()->())
    func selectedRepo(atIndex index: IndexPath)
}

extension TableListViewControllerDelegate {
    func refreshData(completion: @escaping ()->()) {}
}
