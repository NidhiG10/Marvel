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
        addContraints()
    }
    
    func addContraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        name.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
    }
    
    // MARK: - Public methods
    
    func configure(withCharacter character: Character) {
        name.text = character.name
        imageView.download(image: character.image?.fullPath() ?? "")
    }
    
    static func size(for parentWidth: CGFloat) -> CGSize {
        let numberOfCells = CGFloat(2)
        let width = parentWidth / numberOfCells
        return CGSize(width: width, height: width)
    }
}
