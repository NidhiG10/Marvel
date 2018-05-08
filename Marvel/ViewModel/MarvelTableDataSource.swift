//
//  MarvelTableViewModel.swift
//  Marvel
//
//  Created by Nidhi Goyal on 03/05/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class MarvelTableDataSource: NSObject {
    
    let cellReuseIdentifier = "tableCell"
    fileprivate(set) weak var tableView: UITableView?
    fileprivate(set) var characters: [Character]?
    
    var showCharacterDetails: ((Character) -> Void)?
    
    init(tableView: UITableView?, delegate: UITableViewDelegate) {
        super.init()
        
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.tableView?.delegate = delegate
        self.tableView?.register(CharacterTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView?.reloadData()
    }
    
    func process(characters: [Character]?) {
        self.characters = characters
        self.tableView?.reloadData()
    }
}

extension MarvelTableDataSource : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! CharacterTableViewCell
        if let character = self.characters?[indexPath.item] {
            cell.configure(withCharacter: character)
        }
        return cell
    }
}

class MarvelTableDelegate : NSObject, UITableViewDelegate {
    
    let delegate: CharactersDelegate
    
    init(_ delegate: CharactersDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectCharacter(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterTableViewCell.height()
    }
}
