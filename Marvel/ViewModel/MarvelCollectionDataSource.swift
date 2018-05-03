//
//  MarvelCharactersViewModel.swift
//  Marvel
//
//  Created by Nidhi Goyal on 29/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class MarvelCollectionDataSource: NSObject, UICollectionViewDelegateFlowLayout {
    
    let cellReuseIdentifier = "collectionCell"
    fileprivate(set) var characters: [Character]?
    fileprivate(set) weak var collectionView: UICollectionView?
    
    init(collectionView: UICollectionView) {
        super.init()
        
        self.collectionView = collectionView
        self.collectionView?.dataSource = self
        self.collectionView?.register(CharacterCollectionCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        self.collectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width - 10.0
        return CharacterCollectionCell.size(for: width)
    }
    
    func process(characters: [Character]) {
        self.characters = characters
        self.collectionView?.reloadData()
    }
}

extension MarvelCollectionDataSource : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CharacterCollectionCell
        if let character = self.characters?[indexPath.item] {
            cell.configure(withCharacter: character)
        }
        return cell
    }
}

