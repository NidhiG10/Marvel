//
//  MarvelCharactersViewModel.swift
//  Marvel
//
//  Created by Nidhi Goyal on 29/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class MarvelCharactersViewModel: NSObject, MVVMBinding, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    /// Closure used to notify results or messages to the view
    var messagesClosure: ((Message) -> Void)?
    
    fileprivate(set) lazy var networkHandler: MarvelNetworkHandler = {
        let handler = MarvelNetworkHandler()
        handler.subscribe(withClosure: self.didReceiveModelMessageClosure())
        return handler
    }()
    
    let cellReuseIdentifier = "collectionCell"
    fileprivate(set) weak var collectionView: UICollectionView?
    
    fileprivate(set) var characters: [Character]
    
    init(collectionView: UICollectionView) {
        self.characters = []
        super.init()
        
        self.collectionView = collectionView
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(CharacterCollectionCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        self.collectionView?.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CharacterCollectionCell
        let character = self.characters[indexPath.item]
        cell.configure(withCharacter: character)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    fileprivate func process(characters: [Character]) {
        self.characters = characters
        self.collectionView?.reloadData()
    }
}

extension MarvelCharactersViewModel {
    
    enum Signal {
        case fetchCharacters(String?)
    }
    
    enum Message {
        case charactersFetched
        case characterInfofetched
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
                self?.messagesClosure?(.charactersFetched)
                self?.process(characters: characters)
            case .errorReceived(_):
                // TODO: Handle this
                break
            }
        }
    }
    
}
