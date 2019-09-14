//
//  CompactTableViewCell.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class CompactTableViewCell: UITableViewCell {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var indexLabel: UILabel!
    @IBOutlet private var repoNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        containerView.layer.cornerRadius = 4
    }
    
    func configure(withData data: GithubRepoViewModel, index: Int?) {
        repoNameLabel.text = data.name
        guard let index = index else { return }
        indexLabel.text = String(index) + "."
    }
}
