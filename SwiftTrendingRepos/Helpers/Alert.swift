//
//  Alert.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 07/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import UIKit

struct Alert {
    
    static func tryAgain(withTitle title: String, completion: @escaping () -> ()) -> UIAlertController {
        let alertController = UIAlertController(title: title,
                                                message: nil,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        
        let againAction = UIAlertAction(title: "Try Again",
                                        style: .default) { _ in completion() }
        
        alertController.addAction(okAction)
        alertController.addAction(againAction)
        return alertController
    }
}
