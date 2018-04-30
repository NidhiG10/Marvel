//
//  MarvelNetworkHandler.swift
//  Marvel
//
//  Created by Nidhi Goyal on 29/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation
import Moya


class MarvelNetworkHandler: NSObject, MVVMBinding {
    
    var messagesClosure: ((Message) -> Void)?
    fileprivate var statusesQueue: [Character]
    
    override init() {
        self.statusesQueue = []

        super.init()
    }
    
    fileprivate func getCharacters(withQuery query: String?) {
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
            self.getCharacters(withQuery: keyword)
        }
    }
    
}

