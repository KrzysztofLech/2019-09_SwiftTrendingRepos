//
//  UITableViewCell+extensions.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 22/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func moveToVisibleArea(animated: Bool, duration: Double = 1.0) {
        self.alpha = 1.0
        
        guard animated else {
            self.transform = CGAffineTransform.identity
            return
        }
        
        let delay = Double.random(in: 0 ... 0.5)
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: 0.68,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseOut,animations: {
                        self.transform = CGAffineTransform.identity
        })
    }
    
    func moveOutsideVisibleArea(animated: Bool, duration: Double = 0.5) {
        let translation = UIScreen.main.bounds.width
        
        guard animated else {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
            return
        }
        
        let delay = Double.random(in: 0 ... 0.3)
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.0,
                       options: .curveEaseOut,
                       animations: {
                           self.transform = CGAffineTransform(translationX: translation, y: 0)
        })
    }
    
    func animateSelectedItem(completion: @escaping ()->()) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.15, animations: {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.15, relativeDuration: 0.15, animations: {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.alpha = 0.0
            })
        }) { _ in
            completion()
        }
    }
}
