//
//  UITableView+extensions.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(cellAndNibName name: String) {
        let nib = UINib(nibName: name, bundle: nil)
        register(nib, forCellReuseIdentifier: name)
    }
    
    func moveVisibleCellsOutside() {
        let visibleCells = self.visibleCells
        visibleCells.forEach { cell in
            let translation = UIScreen.main.bounds.width
            cell.transform = CGAffineTransform(translationX: -translation, y: 0.0)
        }
    }
    
    func moveCellsToVisibleArea(animated: Bool) {
        let visibleCells = self.visibleCells
        visibleCells.forEach { cell in
            cell.moveToVisibleArea(animated: animated)
        }
    }
  
    func moveCellsOutsideWithAnimations(withoutCellWithIndex selectedCellIndex: IndexPath) {
        guard let indexPathsForVisibleRows = self.indexPathsForVisibleRows else { return }
        
        indexPathsForVisibleRows.forEach { indexPath in
            guard let cell = self.cellForRow(at: indexPath) else { return }
            
            if indexPath != selectedCellIndex {
                cell.moveOutsideVisibleArea(animated: true)
            }
        }
    }
}
