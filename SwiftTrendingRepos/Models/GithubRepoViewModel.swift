//
//  GithubRepoViewModel.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

struct GithubRepoViewModel {

    let author: String
    let name: String
    let avatarUrl: String
    let repoUrl: String
    let description: String
    let stars: String
    let forks: String
    
    init(from githubRepo: GithubRepo) {
        self.author = githubRepo.author
        self.name = githubRepo.name
        self.avatarUrl = githubRepo.avatarUrl
        self.repoUrl = githubRepo.repoUrl
        self.description = githubRepo.description
        self.stars = githubRepo.stars.convertToSting()
        self.forks = githubRepo.forks.convertToSting()
    }
}
