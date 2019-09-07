//
//  SimpleTableViewCell.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class SimpleTableViewCell: UITableViewCell {

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var avatarImageView: UIImageView!
    
    private var avatarUrl = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicator.startAnimating()
        avatarImageView.image = nil
    }
    
    private func setup() {
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.darkGray.cgColor
        
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
    }
    
    func configure(withData data: GithubRepoViewModel) {
        repoNameLabel.text = data.name
        starsLabel.text = String(data.stars)
        authorLabel.text = data.author
        avatarUrl = data.avatarUrl
    }
}
