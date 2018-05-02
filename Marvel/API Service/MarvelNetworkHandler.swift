//
//  MarvelNetworkHandler.swift
//  Marvel
//
//  Created by Nidhi Goyal on 29/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Moya

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

class MarvelNetworkHandler: NSObject, MVVMBinding {
    
    var messagesClosure: ((Message) -> Void)?
//    fileprivate var statusesQueue: [Character]
    
    let provider: MoyaProvider<MarvelAPI>
//    let disposeBag = DisposeBag()
    
    override init() {
        provider = MoyaProvider<MarvelAPI>()
        
        super.init()
        
    }
    
    fileprivate func getCharacters(_ token: MarvelAPI) {
        
        provider.request(token) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.removeAPIWrappers() // Data, your JSON response is probably in here!
//                let statusCode = moyaResponse.statusCode // Int - 200, 401, 500, etc
                
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
                    
                    self.messagesClosure?(.charactersFetched(characterArray))
                    
                }
                catch {
                    self.messagesClosure?(.errorReceived(error))
                }
                
                
            // do something in your app
            case let .failure(error):
                self.messagesClosure?(.errorReceived(error))
                // TODO: handle the error == best. comment. ever.
            }
        }
    }
}

/**
 MVVM Binding methods and definitions
 */
extension MarvelNetworkHandler {
    
    enum Signal {
        case getCharacters(String?)
    }
    
    enum Message {
        case errorReceived(Error?)
        case charactersFetched([Character])
    }
    
    func didReceive(signal: Signal) {
        switch signal {
        case let .getCharacters(keyword):
            self.getCharacters(.showCharacters(keyword))
        }
    }
    
}

