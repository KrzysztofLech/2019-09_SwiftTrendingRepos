//
//  UserDefaultsService.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 15/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import Foundation

enum LayoutStyle: Int {
    case simple
    case varied
}

protocol UserDefaultsServiceProtocol {
    func saveLayoutStyle(_ style: LayoutStyle)
    func getLayoutStyle() -> LayoutStyle
}

final class UserDefaultsService: UserDefaultsServiceProtocol {
    
    private enum UserDefaultsKey {
        static let layout = "layout"
    }

    private func write(object: Any, forKey key: String) {
        UserDefaults.standard.set(object, forKey: key)
    }
    
    private func getObject(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    private func removeObject(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func saveLayoutStyle(_ style: LayoutStyle) {
        write(object: style.rawValue, forKey: UserDefaultsKey.layout)
    }
    
    func getLayoutStyle() -> LayoutStyle {
        guard
            let readStyleValue = getObject(forKey: UserDefaultsKey.layout) as? Int,
            let readStyle = LayoutStyle(rawValue: readStyleValue)
        else { return LayoutStyle.simple }
        return readStyle
    }
}
