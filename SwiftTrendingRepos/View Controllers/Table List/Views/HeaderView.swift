//
//  HeaderView.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 14/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

enum SectionHeader: Int {
    case largeSize
    case regularSize
    case compactSize
    
    var title: String {
        switch self {
        case .largeSize: return "Top 3"
        case .regularSize: return "Top 10"
        case .compactSize: return "Other"
        }
    }
}

final class HeaderView: UIView {

    @IBOutlet private var titleLabel: UILabel!
    
    func setTitleForSection(_ section: Int) {
        titleLabel.text = SectionHeader(rawValue: section)?.title
    }
}
