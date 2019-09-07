//
//  GithubRepo.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 05/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

struct GithubRepo: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case author
        case name
        case avatarUrl = "avatar"
        case repoUrl = "url"
        case description
        case stars
        case forks
    }
    
    let author: String
    let name: String
    let avatarUrl: String
    let repoUrl: String
    let description: String
    let stars: Int
    let forks: Int
}
