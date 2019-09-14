//
//  DetailsView.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 12/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol DetailsViewDelegate: AnyObject {
    func urlButtonTapped()
}

class DetailsView: UIView {
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var authorLabel: UILabel!
    
    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var repoUrlLabel: UILabel!
    
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var forksLabel: UILabel!
    
    weak var delegate: DetailsViewDelegate?
    var image: UIImage? {
        didSet {
            showAvatarImage()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        addGradientBackground()
    }
    
    private func setupView() {
        layer.cornerRadius = 16
        
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 20
        layer.shadowOpacity = 0.5
    }
    
    private func addGradientBackground() {
        let gradientView = GradientView()
        gradientView.layer.cornerRadius = 16
        gradientView.layer.masksToBounds = true
        addSubview(gradientView)
        gradientView.fill(view: self)
        sendSubviewToBack(gradientView)
    }
    
    func configure(data: GithubRepoViewModel, delegate: DetailsViewDelegate) {
        authorLabel.text = data.author
        repoNameLabel.text = data.name
        descriptionLabel.text = data.description
        repoUrlLabel.text = data.repoUrl
        starsLabel.text = data.stars
        forksLabel.text = data.forks

        self.delegate = delegate
    }
    
    private func showAvatarImage() {
        activityIndicator.stopAnimating()
        
        if let image = image {
            avatarImageView.backgroundColor = .white
            avatarImageView.image = image
        } else {
            avatarImageView.backgroundColor = .clear
            avatarImageView.image = UIImage(named: "githubAvatarPlaceholder")
        }
    }
    
    @IBAction func repoUrlButtonAction() {
        delegate?.urlButtonTapped()
    }
}
