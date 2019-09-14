//
//  GradientView.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 10/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

enum GradientSet: String {
    case background
    case objectBackground
    case toolBarBackground
    
    var startColor: CGColor {
        switch self {
        case .background:         return UIColor(red: 54/255, green: 54/255, blue: 70/255, alpha: 1.0).cgColor
        //case .objectBackground:   return UIColor(red: 79/255, green: 79/255, blue: 97/255, alpha: 1.0).cgColor
        //case .background:         return UIColor(red: 0/255, green: 0/255, blue: 100/255, alpha: 1.0).cgColor
        case .objectBackground:   return UIColor(red: 0/255, green: 0/255, blue: 140/255, alpha: 1.0).cgColor
        case .toolBarBackground:  return UIColor(red: 54/255, green: 54/255, blue: 70/255, alpha: 1.0).cgColor
        }
    }
    
    var endColor: CGColor {
        switch self {
        case .background:          return UIColor(red: 31/255, green: 31/255, blue: 42/255, alpha: 1.0).cgColor
        //case .objectBackground:    return UIColor(red: 34/255, green: 34/255, blue: 44/255, alpha: 1.0).cgColor
        //case .background:          return UIColor(red: 0/255, green: 0/255, blue: 60/255, alpha: 1.0).cgColor
        case .objectBackground:    return UIColor(red: 0/255, green: 0/255, blue: 80/255, alpha: 1.0).cgColor
        case .toolBarBackground:   return UIColor(red: 31/255, green: 31/255, blue: 42/255, alpha: 1.0).cgColor
        }
    }
}

import UIKit

class GradientView: UIView {
    
    @IBInspectable var colorSet: String = "" {
        didSet {
            gradientSet = GradientSet(rawValue: colorSet) ?? .background
        }
    }
    
    var gradientSet = GradientSet.objectBackground
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [gradientSet.startColor, gradientSet.endColor]
        let colorLocations: [CGFloat] = [0.0, 1.0]
        guard
            let gradient = CGGradient(colorsSpace: colorSpace,
                                      colors: colors as CFArray,
                                      locations: colorLocations)
            else { return }
        
        let startPoint = CGPoint.zero
        var endPoint = CGPoint.zero
        
        switch gradientSet {
        case .background, .objectBackground:
            endPoint = CGPoint(x: bounds.width, y: bounds.height)
        case .toolBarBackground:
            endPoint = CGPoint(x: 0, y: bounds.height)
        }
        
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
}
