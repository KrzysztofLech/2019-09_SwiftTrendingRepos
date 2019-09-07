//
//  SimpleTableViewCell.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

class SimpleTableViewCell: UITableViewCell {

    @IBOutlet private var repoNameLabel: UILabel!
    
    func configure(withData data: GithubRepo) {
        repoNameLabel.text = data.name
    }
}
