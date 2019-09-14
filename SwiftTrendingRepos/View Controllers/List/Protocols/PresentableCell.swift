//
//  PresentableCell.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

protocol PresentableCell {
    func configure(withData data: GithubRepoViewModel)
    func setupAvatarImage(_ image: UIImage?)
}
