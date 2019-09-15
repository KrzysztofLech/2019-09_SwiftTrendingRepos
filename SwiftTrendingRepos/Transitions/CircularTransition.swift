//
//  CircularTransition.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 15/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class CircularTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let totalTransitionDuration = 2.0
    
    private var transitionContext: UIViewControllerContextTransitioning?
    private var toView: UIView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return totalTransitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: .from) as? StartViewController,
            let toView = transitionContext.view(forKey: .to)
        else { return }
        
        self.transitionContext = transitionContext
        self.toView = toView
        
        toView.frame = fromVC.view.frame
        transitionContext.containerView.addSubview(toView)

        hideLogo(fromVC.logoImageView)
        hideTitle(fromVC.titleLabel)
        maskAnimation(centerPoint: fromVC.view.center)
    }
    
    private func hideLogo(_ logo: UIImageView?) {
        UIView.animate(withDuration: totalTransitionDuration * 0.5, animations: {
            logo?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { _ in
            logo?.isHidden = true
        }
    }
    
    private func hideTitle(_ titleLabel: UILabel?) {
        UIView.animate(withDuration: totalTransitionDuration * 0.5) {
            titleLabel?.alpha = 0.0
        }
    }
    
    private func maskAnimation(centerPoint: CGPoint) {
        let radius = sqrt(centerPoint.x * centerPoint.x + centerPoint.y * centerPoint.y)
        
        let startCircleRectangle = CGRect(x: centerPoint.x, y: centerPoint.y,width: 0, height: 0)
        let startCirclePath = UIBezierPath(ovalIn: startCircleRectangle)
        let endCirclePath = UIBezierPath(ovalIn: startCircleRectangle.insetBy(dx: -radius, dy: -radius))
        
        let mask = CAShapeLayer()
        mask.path = startCirclePath.cgPath
        toView?.layer.mask = mask
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = startCirclePath.cgPath
        maskLayerAnimation.toValue = endCirclePath.cgPath
        maskLayerAnimation.duration =  totalTransitionDuration * 0.4
        maskLayerAnimation.beginTime = CACurrentMediaTime() + totalTransitionDuration * 0.6
        maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        maskLayerAnimation.delegate = self
        
        mask.add(maskLayerAnimation, forKey: "path")
    }
}

extension CircularTransition: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        toView?.layer.mask = nil
        transitionContext?.completeTransition(true)
    }
}

extension CircularTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
