//
//  LargeCollectionViewCell.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

class LargeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var avatarImageView: UIImageView!
    
    @IBOutlet private var authorLabel: UILabel!
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var forksLabel: UILabel!
    
    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 4
        avatarImageView.layer.cornerRadius = 8
    }
    
    func configure(withData data: GithubRepoViewModel) {
        authorLabel.text = data.author
        starsLabel.text = String(data.stars)
        forksLabel.text = String(data.forks)
        repoNameLabel.text = data.name
        descriptionTextView.text = data.description
    }
    
    func setupAvatarImage(_ image: UIImage?) {
        activityIndicator.stopAnimating()
        
        if let image = image {
            avatarImageView.image = image
        } else {
            avatarImageView.backgroundColor = .clear
            avatarImageView.image = UIImage(named: "githubAvatarPlaceholder")
        }
    }
}
