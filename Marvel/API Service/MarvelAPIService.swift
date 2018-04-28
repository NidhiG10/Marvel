//
//  MarvelAPIService.swift
//  Marvel
//
//  Created by Nidhi Goyal on 28/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Moya
import CryptoSwift

struct MarvelAPIConfiguration {
    static let apiKey = "3de22899a20f18c46bb1148ae9822f28"
    static let privateKey = "709a1023bc3eef7c37ea2320a0c27fa8f22c3acd"
    static let timeStamp = Date().timeIntervalSince1970.description
    static let hashKey = "\(timeStamp)\(privateKey)\(apiKey)".md5()
}

enum MarvelAPI {
    case showCharacters(String?)
    case showCharacterDetails(String)
}

extension MarvelAPI: TargetType {
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var baseURL: URL { return URL(string: "")! }
    
    
    var path: String {
        switch self {
        case .showCharacters:
            return "/v1/public/characters"
        case .showCharacterDetails(let characterId):
            return "/v1/public/characters/\(characterId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .showCharacters, .showCharacterDetails:
            return .get
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
    
    func authParameters() -> [String: String] {
        return ["apikey": MarvelAPIConfiguration.apiKey,
                "ts": MarvelAPIConfiguration.timeStamp,
                "hash": MarvelAPIConfiguration.hashKey]
    }
}
