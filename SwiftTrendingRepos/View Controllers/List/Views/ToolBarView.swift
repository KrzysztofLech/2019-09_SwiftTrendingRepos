//
//  ToolBarView.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

class ToolBarView: UIView {
    
    @IBOutlet private var counterLabel: UILabel!
    
    func changeCounterValue(_ value: Int) {
        counterLabel.text = String(value)
        animateCounter()
    }
    
    private func animateCounter() {
        UIView.animate(withDuration: 0.15, animations: {
            self.counterLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.counterLabel.transform = CGAffineTransform.identity
            }
        }
    }
}
