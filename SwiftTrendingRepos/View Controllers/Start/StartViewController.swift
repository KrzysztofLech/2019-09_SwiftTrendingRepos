//
//  StartViewController.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 05/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

final class StartViewController: UIViewController {
    
    
    @IBAction func buttonAction() {
        let listViewController = ListViewController(nibName: ListViewController.toString(), bundle: nil)
        listViewController.modalTransitionStyle = .crossDissolve
        present(listViewController, animated: true)
    }
}
