//
//  MarvelAPIService.swift
//  Marvel
//
//  Created by Nidhi Goyal on 28/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Moya

enum MarvelAPI {
    case showCharacters(String?)
    case showCharacterDetails(String)
}

extension MarvelAPI: TargetType {
    var baseURL: URL { return URL(string: "")! }
    
    
    var path: String {
        switch self {
        case .showCharacters:
            return "/v1/public/characters"
        case .characterDetails(let characterId):
            return "/v1/public/characters/\(characterId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .showCharacters, .characterDetails:
            return .get
        }
    }
    
    var task: Task {
        return .request
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data()
        }
    }
}
