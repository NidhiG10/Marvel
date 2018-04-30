//
//  CharacterCollectionViewCell.swift
//  Marvel
//
//  Created by Nidhi Goyal on 29/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class CharacterCollectionCell: UICollectionViewCell {
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        return view
    }()
    
    var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = UIColor.green
        return imgView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        contentView.addSubview(imageView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(name)
    }
    
    func addContraints() {
        name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        name.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        name.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        name.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        bottomView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        bottomView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor)
        imageView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor)
        imageView.topAnchor.constraint(equalTo: bottomView.topAnchor)
        imageView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
    }
    
    // MARK: - Public methods
    
    func configure(withCharacter character: Character) {
        self.name.text = character.name
    }
}
