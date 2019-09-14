//
//  GradientView.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 10/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

enum ColorSet {
    static let set1 = [#colorLiteral(red: 0.9568627451, green: 0.5294117647, blue: 0.1921568627, alpha: 1), #colorLiteral(red: 0.8470588235, green: 0.8784313725, blue: 0.08235294118, alpha: 1)]
    static let set2 = [#colorLiteral(red: 0.4862745098, green: 0.1333333333, blue: 0.537254902, alpha: 1), #colorLiteral(red: 0.1764705882, green: 0.1490196078, blue: 0.4352941176, alpha: 1)]
    static let set3 = [#colorLiteral(red: 0.3843137255, green: 0.1529411765, blue: 0.4549019608, alpha: 1), #colorLiteral(red: 0.7725490196, green: 0.2, blue: 0.3921568627, alpha: 1)]
    static let set4 = [#colorLiteral(red: 0, green: 0, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0.3137254902, alpha: 1)]
    static let set5 = [#colorLiteral(red: 0.1921568627, green: 0.1921568627, blue: 0.1921568627, alpha: 1), #colorLiteral(red: 0.3254901961, green: 0.3019607843, blue: 0.3019607843, alpha: 1)]
    static let set6 = [#colorLiteral(red: 0.2117647059, green: 0.2117647059, blue: 0.2745098039, alpha: 1), #colorLiteral(red: 0.1215686275, green: 0.1215686275, blue: 0.1647058824, alpha: 1)]
    static let set7 = [#colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3803921569, alpha: 1), #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1725490196, alpha: 1)]
    static let set8 = [#colorLiteral(red: 0, green: 0, blue: 0.3921568627, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0.2352941176, alpha: 1)]
    static let set9 = [#colorLiteral(red: 0, green: 0, blue: 0.7843137255, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0.3137254902, alpha: 1)]
}

enum GradientSet: String {
    case background
    case objectBackground
    case toolBarBackground
    
    var colors: [UIColor] {
        switch self {
            case .background: return ColorSet.set1
            case .objectBackground: return ColorSet.set9
            case .toolBarBackground: return ColorSet.set6
        }
    }
}

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
        let rgbColors = gradientSet.colors
        let cgColors = rgbColors.map { $0.cgColor }
        let colorLocations: [CGFloat] = [0.0, 1.0]
        guard
            let gradient = CGGradient(colorsSpace: colorSpace,
                                      colors: cgColors as CFArray,
                                      locations: colorLocations)
            else { return }
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: bounds.width, y: bounds.height)
        
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
}
