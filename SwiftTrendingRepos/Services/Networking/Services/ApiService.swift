//
//  ApiService.swift
//  SwiftTrendingRepos
//
//  Created by Krzysztof Lech on 05/09/2019.
//  Copyright © 2019 Krzysztof Lech. All rights reserved.
//

import Foundation

enum ApiService: ServiceProtocol {
    case getRepos
    
    var baseURL: URL {
        return URL(string: "https://github-trending-api.now.sh")!
    }
    
    var path: String {
        return "repositories"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: NetworkTask {
        switch self {
        case .getRepos:
            let parameters: NetworkParameters = [
                "language": "swift",
                "since": "monthly"
            ]
            return .requestParameters(parameters)
        }
    }
    
    var headers: Headers? {
        return Headers()
    }
    
    var parametersEncoding: ParametersEncoding {
        return .url
    }
}
