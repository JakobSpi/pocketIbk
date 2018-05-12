//
//  MoyaService.swift
//  pocketIBK
//
//  Created by Jakob on 15.02.18.
//  Copyright © 2018 Jakob. All rights reserved.
//

import Foundation
import Moya

enum MovieService {
    case today
    case movie(id: String)
    case theater(id: String)
}

extension MovieService: TargetType {
    var sampleData: Data {
        return Data()
    }
    var baseURL: URL { return URL(string: "https://dev.sengaro.com/cinema")! }
    var path: String {
        switch self {
        case .today:
            return "/performance/today.json"
        case .movie(let identification):
            return "/movie/\(identification).json"
        case .theater(let identification):
            return "/theater/\(identification).json"
        }
    }
    var method: Moya.Method {
        switch self {
        case .today, .movie(_), .theater(_):
            return .get
        }
    }
    var task: Task {
        return .requestPlain
    }
    var headers: [String: String]? {
        return nil
    }
}
