//
//  DetailsViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 08/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private var containerView: UIView!
    
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var authorLabel: UILabel!
    
    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var repoUrlLabel: UILabel!
    
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var forksLabel: UILabel!
    
    var repoItem: GithubRepoViewModel?
    private var imageService: ImageServiceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageService = ImageService()
        presentData()
    }
    
    private func presentData() {
        guard let data = repoItem else { return }
        
        authorLabel.text = data.author
        repoNameLabel.text = data.name
        descriptionLabel.text = data.description
        repoUrlLabel.text = data.repoUrl
        starsLabel.text = data.stars
        forksLabel.text = data.forks
        
        imageService?.getImage(url: data.avatarUrl) { [weak self] image in
            self?.activityIndicator.stopAnimating()
            
            if let image = image {
                self?.avatarImageView.backgroundColor = .white
                self?.avatarImageView.image = image
            } else {
                self?.avatarImageView.backgroundColor = .clear
                self?.avatarImageView.image = UIImage(named: "githubAvatarPlaceholder")
            }
        }
    }
    
    @IBAction func closeButtonAction() {
        dismiss(animated: true)
    }
    
    @IBAction func repoUrlButtonAction() {
    }
}
