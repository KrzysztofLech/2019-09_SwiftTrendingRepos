//
//  Int+extensions.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

extension Int {
    
    func convertToSting() -> String {
        switch self {
        case ..<0: return "-"
        case 0...999: return String(self)
        default:
            let thousandValue = Float(self) / 1000
            return String(format: "%.1fk", thousandValue)
        }
    }
}
