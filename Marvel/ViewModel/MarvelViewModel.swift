//
//  MarvelViewModel.swift
//  Marvel
//
//  Created by Nidhi Goyal on 03/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class MarvelViewModel: NSObject, MVVMBinding {
    
    /// Closure used to notify results or messages to the view
    var messagesClosure: ((Message) -> Void)?
    var characters: [Character]
    
    fileprivate(set) lazy var networkHandler: MarvelNetworkHandler = {
        let handler = MarvelNetworkHandler()
        handler.subscribe(withClosure: self.didReceiveModelMessageClosure())
        return handler
    }()
    
    override init() {
        characters = []
        super.init()
    }
    
    public func process(characters: [Character]) {
        self.characters = characters
    }
}

extension MarvelViewModel: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let query = searchBar.text ?? ""
        if !query.isEmpty {
            self.messagesClosure?(.fetchingCharacters)
            self.networkHandler.send(signal: .getCharacters(query))
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MarvelViewModel {
    
    enum Signal {
        case fetchCharacters(String?)
    }
    
    enum Message {
        case fetchingCharacters
        case charactersFetched([Character])
        case showCharacterDetails(Character)
    }
    
    func didReceive(signal: Signal) {
        switch signal {
        case let .fetchCharacters(keyword):
            self.networkHandler.send(signal: .getCharacters(keyword))
        }
    }
    
    /**
     Messages received from model
     */
    func didReceiveModelMessageClosure() -> ((MarvelNetworkHandler.Message) -> Void) {
        return { [weak self] message in
            switch message {
            case let .charactersFetched(characters):
                self?.messagesClosure?(.charactersFetched(characters))
                self?.process(characters: characters)
            case .errorReceived(_):
                // TODO: Handle this
                break
            }
        }
    }
    
}
