//
//  MarvelNetworkHandler.swift
//  Marvel
//
//  Created by Nidhi Goyal on 29/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Moya

protocol MavelNetworkHandlerProtocol {
    func getCharacters(_ token: MarvelAPI, completion: @escaping ([Character]?) -> Void)
}

extension Response {
    func removeAPIWrappers() -> Response {
        guard let json = try? self.mapJSON() as? Dictionary<String, AnyObject>,
            let results = json?["data"]?["results"] ?? [],
            let newData = try? JSONSerialization.data(withJSONObject: results, options: .prettyPrinted) else {
                return self
        }
        
        let newResponse = Response(statusCode: self.statusCode,
                                   data: newData,
                                   response: self.response)
        return newResponse
    }
}

struct MarvelNetworkHandler {
    let provider: MoyaProvider<MarvelAPI>
    
    init() {
        provider = MoyaProvider<MarvelAPI>()
    }
}

extension MarvelNetworkHandler {
    
    func requestCharacters(_ token: MarvelAPI, completion: (([Character]?) -> Void)?) {
        provider.request(token) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.removeAPIWrappers()
                
                do {
                    let jsonData = try data.mapJSON()
                    let json = JSON(jsonData)
                    //                    guard let code = json.object?["code"]?.integer && code == 200 else {
                    //                        return self.messagesClosure?(.errorReceived(MarvelError())
                    //                    }
                    //                    return code
                    
                    var characterArray: [Character] = []
                    guard let characters = json.array else { return }
                    for characterInfo in characters {
                        if let character = Character.entity(withDictionary: characterInfo.object!) {
                            characterArray.append(character)
                        }
                    }
                    
                    completion?(characterArray)
                    
                }
                catch {
                    completion?(nil)
                }
                
                
            // do something in your app
            case .failure(_):
                completion?(nil)
            }
        }
    }
}

extension MarvelNetworkHandler : MavelNetworkHandlerProtocol {
    func getCharacters(_ token: MarvelAPI, completion: @escaping ([Character]?) -> Void) {
        requestCharacters(token, completion: completion)
    }
}
