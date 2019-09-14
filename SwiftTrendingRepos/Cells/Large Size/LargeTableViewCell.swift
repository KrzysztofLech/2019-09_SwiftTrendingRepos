//
//  LargeTableViewCell.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class LargeTableViewCell: UITableViewCell {
    
    let largeCollectionViewController = LargeCollectionViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let collectionView = largeCollectionViewController.view else { return }
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    func configure(withData data: [GithubRepoViewModel], delegate: TableListViewControllerDelegate?) {
        largeCollectionViewController.data = data
        largeCollectionViewController.delegate = delegate
    }
}

