//
//  MarvelViewModel.swift
//  Marvel
//
//  Created by Nidhi Goyal on 03/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

protocol CharactersDelegate {
    func didSelectCharacter(at index: IndexPath)
}


class MarvelViewModel: NSObject {
    var isShowingList = true
    var collectionView : UICollectionView?
    var tableView : UITableView?
    var activityIndicator : UIActivityIndicatorView?
    
    var characters: [Character] = []
    var networkHandler: MavelNetworkHandlerProtocol = MarvelNetworkHandler()
    var collectionViewDataSource: MarvelCollectionDataSource?
    var collectionViewDelegate: MarvelCollectionDelegate?
    var tableViewDataSource: MarvelTableDataSource?
    var tableViewDelegate: MarvelTableDelegate?
    
    var showCharacterDetails: ((Character) -> Void)?
    
    init(collectionView: UICollectionView, tableView: UITableView, activityIndicator:UIActivityIndicatorView) {
        super.init()
        self.collectionView = collectionView
        self.tableView = tableView
        self.activityIndicator = activityIndicator
        
        collectionViewDelegate = MarvelCollectionDelegate(self)
        tableViewDelegate = MarvelTableDelegate(self)
        
        collectionViewDataSource = MarvelCollectionDataSource(collectionView: self.collectionView, delegate:collectionViewDelegate!)
        tableViewDataSource = MarvelTableDataSource(tableView:self.tableView, delegate: tableViewDelegate!)
    }
    
}

extension MarvelViewModel {
    public func showAsGrid(value: Bool) {
        self.isShowingList = !value
        self.reloadData(characters: self.characters)
    }
    
    public func fetchCharacters(query: String?) {
        networkHandler.getCharacters(.showCharacters(query)) {[unowned self] (characters) in
            if let characters = characters {
                self.characters = characters
            }
            self.reloadData(characters: characters)
        }
    }
}

extension MarvelViewModel : CharactersDelegate {
    func didSelectCharacter(at index: IndexPath) {
        if index.row <= characters.count - 1 {
            let character = characters[index.row]
            self.showCharacterDetails?(character)
        }
    }
}


extension MarvelViewModel {
    func reloadData(characters: [Character]?) {
        self.activityIndicator?.stopAnimating()
        if isShowingList {
            self.collectionView?.isHidden = true
            self.tableView?.isHidden = false
            self.tableViewDataSource?.process(characters: characters)
        } else {
            self.tableView?.isHidden = true
            self.collectionView?.isHidden = false
            self.collectionViewDataSource?.process(characters: characters)
        }
    }
}

